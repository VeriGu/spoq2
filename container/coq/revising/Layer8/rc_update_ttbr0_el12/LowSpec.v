Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_rc_update_ttbr0_el12_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rc_update_ttbr0_el12_spec_low (v_0: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (Some st)
    else (
      when v_3, st_0 == ((iasm_81_spec st));
      if ((v_3 - (v_0)) =? (0))
      then (Some st_0)
      else (
        when st_1 == ((iasm_82_spec v_0 st_0));
        when st_2 == ((iasm_12_isb_spec st_1));
        (Some st_2))).

End Layer8_rc_update_ttbr0_el12_LowSpec.

#[global] Hint Unfold rc_update_ttbr0_el12_spec_low: spec.
