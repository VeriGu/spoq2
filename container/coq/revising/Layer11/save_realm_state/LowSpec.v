Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_save_realm_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition save_realm_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((save_sysreg_state_spec (ptr_offset v_0 288) st));
    when v_3, st_1 == ((iasm_get_elr_el2_spec st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 272) v_3 st_1));
    when v_5, st_3 == ((iasm_get_spsr_el2_spec st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 280) v_5 st_3));
    when st_5 == ((gic_save_state_spec (ptr_offset v_0 584) st_4));
    (Some st_5).

End Layer11_save_realm_state_LowSpec.

#[global] Hint Unfold save_realm_state_spec_low: spec.
