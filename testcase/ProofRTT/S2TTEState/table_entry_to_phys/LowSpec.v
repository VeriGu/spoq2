Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEState_table_entry_to_phys_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition table_entry_to_phys_spec_low (v_entry1: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((addr_level_mask_spec v_entry1 3 st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End S2TTEState_table_entry_to_phys_LowSpec.

#[global] Hint Unfold table_entry_to_phys_spec_low: spec.
