Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_pack_struct_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition pack_struct_return_code_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((v_0 >> (24)) & (4294967040)) |' (v_0)), st)).

End Layer5_pack_struct_return_code_LowSpec.

#[global] Hint Unfold pack_struct_return_code_spec_low: spec.
