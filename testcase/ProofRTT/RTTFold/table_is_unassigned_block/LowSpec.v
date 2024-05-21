Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RTTFold_table_is_unassigned_block_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition table_is_unassigned_block_spec_low (v_table: Ptr) (v_ripas: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_call, st == ((__table_is_uniform_block_spec v_table (mkPtr "s2tte_is_unassigned" 0) v_ripas st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End RTTFold_table_is_unassigned_block_LowSpec.

#[global] Hint Unfold table_is_unassigned_block_spec_low: spec.
