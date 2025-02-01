Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_slot_to_va_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition slot_to_va_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr ((int_to_ptr 18446744071562067968).(pbase)) (((int_to_ptr 18446744071562067968).(poffset)) + ((1 * ((((CPU_ID * (9)) + (v_0)) << (12))))))), st)).

End Layer5_slot_to_va_LowSpec.

#[global] Hint Unfold slot_to_va_spec_low: spec.
