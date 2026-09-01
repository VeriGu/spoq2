Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MakeReturnCode_make_return_code_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition make_return_code_spec_low (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_index << (32)) + (v_status)), st)).

End MakeReturnCode_make_return_code_LowSpec.

#[global] Hint Unfold make_return_code_spec_low: spec.
