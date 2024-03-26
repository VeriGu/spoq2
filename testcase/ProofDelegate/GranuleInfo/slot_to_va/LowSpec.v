Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_slot_to_va_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition slot_to_va_spec_low (v_slot: Z) (st: RData) : (option (Z * RData)) :=
    let v_mul := (v_slot << (12)) in
    let v_conv := v_mul in
    let v_add := (v_conv + (18446744073709420544)) in
    let __return__ := true in
    let __retval__ := v_add in
    (Some (__retval__, st)).

End GranuleInfo_slot_to_va_LowSpec.

#[global] Hint Unfold slot_to_va_spec_low: spec.
