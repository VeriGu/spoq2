Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_complete_sysreg_emulation_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition complete_sysreg_emulation_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 952) st));
    when v_5, st_1 == ((esr_sysreg_rt_spec v_4 st_0));
    if ((v_4 & (4227858432)) =? (1610612736))
    then (
      if (
        if ((v_4 & (1)) =? (0))
        then true
        else (v_5 =? (31)))
      then (Some st_1)
      else (
        when v_13, st_2 == ((load_RData 8 (ptr_offset v_1 64) st_1));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
        when st_3 == ((store_RData 8 (ptr_offset v_0 (24 + ((8 * (v_5))))) v_13 st_2));
        (Some st_3)))
    else (Some st_1).

End Layer12_complete_sysreg_emulation_LowSpec.

#[global] Hint Unfold complete_sysreg_emulation_spec_low: spec.
