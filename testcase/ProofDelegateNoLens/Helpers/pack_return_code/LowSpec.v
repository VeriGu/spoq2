Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_pack_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition pack_return_code_spec_low (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((make_return_code_spec v_status v_index st));
    when v_call1, st == ((pack_struct_return_code_spec v_call st));
    let __return__ := true in
    let __retval__ := v_call1 in
    (Some (__retval__, st)).

End Helpers_pack_return_code_LowSpec.

#[global] Hint Unfold pack_return_code_spec_low: spec.
