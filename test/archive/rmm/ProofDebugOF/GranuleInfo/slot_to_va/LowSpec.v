Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_slot_to_va_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition slot_to_va_spec_low (v_slot: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_slot << (12)) + (18446744073709420544)), st)).

End GranuleInfo_slot_to_va_LowSpec.

#[global] Hint Unfold slot_to_va_spec_low: spec.
