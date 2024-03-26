Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MakeReturnCode_pack_struct_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition pack_struct_return_code_spec_low (v_return_code_coerce: Z) (st: RData) : (option (Z * RData)) :=
    let v_sh_diff := (v_return_code_coerce >> (24)) in
    let v_shl := (v_sh_diff & (4294967040)) in
    let v_return_code_coerce_masked := (v_return_code_coerce & (4294967295)) in
    let v_conv := (v_shl |' (v_return_code_coerce_masked)) in
    let __return__ := true in
    let __retval__ := v_conv in
    (Some (__retval__, st)).

End MakeReturnCode_pack_struct_return_code_LowSpec.

#[global] Hint Unfold pack_struct_return_code_spec_low: spec.
