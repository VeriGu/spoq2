Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MakeReturnCode_pack_struct_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition pack_struct_return_code_spec_low (v_return_code_coerce: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((v_return_code_coerce >> (24)) & (4294967040)) |' ((v_return_code_coerce & (4294967295)))), st)).

End MakeReturnCode_pack_struct_return_code_LowSpec.

#[global] Hint Unfold pack_struct_return_code_spec_low: spec.
