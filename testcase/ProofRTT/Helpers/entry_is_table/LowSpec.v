Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_entry_is_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition entry_is_table_spec_low (v_entry1: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_entry1 & (3)) in
    let v_cmp := (v_and =? (3)) in
    let __return__ := true in
    let __retval__ := v_cmp in
    (Some (__retval__, st)).

End Helpers_entry_is_table_LowSpec.

#[global] Hint Unfold entry_is_table_spec_low: spec.
