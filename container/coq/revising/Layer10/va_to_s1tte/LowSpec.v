Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_va_to_s1tte_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition va_to_s1tte_spec_low (v_0: Ptr) (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - ((((ptr_to_int v_0) + (2147483648)) >> (12)))) <= (0)) /\ (((((ptr_to_int v_0) + (2147483648)) >> (12)) < (512)))));
    (Some ((ptr_offset (mkPtr "tt_l3_buffer" 0) (8 * ((((ptr_to_int v_0) + (2147483648)) >> (12))))), st)).

End Layer10_va_to_s1tte_LowSpec.

#[global] Hint Unfold va_to_s1tte_spec_low: spec.
