Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_restore_realm_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition restore_realm_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 536) st));
    when st_1 == ((iasm_set_cnthctl_el2_spec v_4 st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    when st_3 == ((restore_sysreg_state_spec (ptr_offset v_0 288) st_2));
    when v_6, st_4 == ((load_RData 8 (ptr_offset v_0 272) st_3));
    when st_5 == ((iasm_set_elr_el2_spec v_6 st_4));
    when v_8, st_6 == ((load_RData 8 (ptr_offset v_0 280) st_5));
    when st_7 == ((iasm_set_spsr_el2_spec v_8 st_6));
    when v_10, st_8 == ((load_RData 8 (ptr_offset v_0 808) st_7));
    when st_9 == ((iasm_set_hcr_el2_spec v_10 st_8));
    when st_10 == ((gic_restore_state_spec (ptr_offset v_0 584) st_9));
    (Some st_10).

End Layer11_restore_realm_state_LowSpec.

#[global] Hint Unfold restore_realm_state_spec_low: spec.
