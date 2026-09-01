Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_pack_struct_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition pack_struct_return_code_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    let v__sroa_0_0_extract_trunc := v_0 in
    let v_sh_diff := (v_0 >> (24)) in
    let v_tr_sh_diff := v_sh_diff in
    let v_2 := (v_tr_sh_diff & (4294967040)) in
    let v_3 := (v_2 |' (v__sroa_0_0_extract_trunc)) in
    let __return__ := true in
    let __retval__ := v_3 in
    (Some (__retval__, st)).

End Layer5_pack_struct_return_code_LowSpec.

#[global] Hint Unfold pack_struct_return_code_spec_low: spec.
