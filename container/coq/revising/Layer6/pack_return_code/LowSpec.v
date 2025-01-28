Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_pack_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition pack_return_code_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((make_return_code_spec v_0 v_1 st));
    when v_4, st_1 == ((pack_struct_return_code_spec v_3 st_0));
    (Some (v_4, st_1)).

End Layer6_pack_return_code_LowSpec.

#[global] Hint Unfold pack_return_code_spec_low: spec.
