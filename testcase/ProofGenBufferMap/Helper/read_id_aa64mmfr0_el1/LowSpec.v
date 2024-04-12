Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helper_read_id_aa64mmfr0_el1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition read_id_aa64mmfr0_el1_spec_low (st: RData) : (option (Z * RData)) :=
    when v_0, st == ((iasm_18_spec st));
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End Helper_read_id_aa64mmfr0_el1_LowSpec.

#[global] Hint Unfold read_id_aa64mmfr0_el1_spec_low: spec.
