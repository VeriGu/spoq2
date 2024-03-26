Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_mpidr_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition mpidr_is_valid_spec_low (v_mpidr: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_mpidr & (18446742978476114160)) in
    let v_cmp := (v_and =? (0)) in
    let __return__ := true in
    let __retval__ := v_cmp in
    (Some (__retval__, st)).

End Helpers_mpidr_is_valid_LowSpec.

#[global] Hint Unfold mpidr_is_valid_spec_low: spec.
