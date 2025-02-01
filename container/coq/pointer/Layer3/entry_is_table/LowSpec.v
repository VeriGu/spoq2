Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_entry_is_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition entry_is_table_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (3)) =? (3)), st)).

End Layer3_entry_is_table_LowSpec.

#[global] Hint Unfold entry_is_table_spec_low: spec.
