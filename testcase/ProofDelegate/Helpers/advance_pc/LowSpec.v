Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_advance_pc_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition advance_pc_spec_low (st: RData) : (option RData) :=
    when v_call, st == ((read_elr_el2_spec st));
    let v_add := (v_call + (4)) in
    when st == ((write_elr_el2_spec v_add st));
    let __return__ := true in
    (Some st).

End Helpers_advance_pc_LowSpec.

#[global] Hint Unfold advance_pc_spec_low: spec.
