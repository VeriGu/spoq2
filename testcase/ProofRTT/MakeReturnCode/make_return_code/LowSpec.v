Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MakeReturnCode_make_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition make_return_code_spec_low (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
    let v_retval_sroa_2_0_insert_ext := v_index in
    let v_retval_sroa_2_0_insert_shift := (v_retval_sroa_2_0_insert_ext << (32)) in
    let v_retval_sroa_0_0_insert_ext := v_status in
    let v_retval_sroa_0_0_insert_insert := (v_retval_sroa_2_0_insert_shift + (v_retval_sroa_0_0_insert_ext)) in
    let __return__ := true in
    let __retval__ := v_retval_sroa_0_0_insert_insert in
    (Some (__retval__, st)).

End MakeReturnCode_make_return_code_LowSpec.

#[global] Hint Unfold make_return_code_spec_low: spec.
