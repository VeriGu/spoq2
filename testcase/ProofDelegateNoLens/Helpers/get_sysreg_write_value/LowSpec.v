Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_get_sysreg_write_value_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_sysreg_write_value_spec_low (v_rec: Ptr) (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    let v_0 := v_esr in
    let v_1 := (v_0 >> (5)) in
    let v_conv := (v_1 & (31)) in
    let v_cmp := (v_conv =? (31)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp
        then (
          let v_retval_0 := 0 in
          (Some (v_retval_0, st)))
        else (
          let v_idxprom := v_conv in
          rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (31)))));
          let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (v_idxprom)) + (0))))))) in
          when v_2, st == ((load_RData 8 v_arrayidx st));
          let v_retval_0 := v_2 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End Helpers_get_sysreg_write_value_LowSpec.

#[global] Hint Unfold get_sysreg_write_value_spec_low: spec.
