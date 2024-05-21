Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RTTFold_table_is_destroyed_block_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition table_is_destroyed_block_spec_low (v_table: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_call, st == ((__table_is_uniform_block_spec v_table (mkPtr "s2tte_is_destroyed" 0) (mkPtr "null" 0) st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End RTTFold_table_is_destroyed_block_LowSpec.

#[global] Hint Unfold table_is_destroyed_block_spec_low: spec.
