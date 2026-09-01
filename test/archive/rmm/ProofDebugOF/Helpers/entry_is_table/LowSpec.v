Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_entry_is_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition entry_is_table_spec_low (v_entry1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_entry1 & (3)) =? (3)), st)).

End Helpers_entry_is_table_LowSpec.

#[global] Hint Unfold entry_is_table_spec_low: spec.
