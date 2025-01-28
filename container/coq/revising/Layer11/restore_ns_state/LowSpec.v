Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_restore_ns_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition restore_ns_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((restore_sysreg_state_spec (ptr_offset v_0 0) st));
    when v_4, st_1 == ((load_RData 8 (ptr_offset v_0 248) st_0));
    when st_2 == ((iasm_set_cnthctl_el2_spec v_4 st_1));
    when v_6, st_3 == ((load_RData 8 (ptr_offset v_0 560) st_2));
    when st_4 == ((iasm_145_spec v_6 st_3));
    (Some st_4).

End Layer11_restore_ns_state_LowSpec.

#[global] Hint Unfold restore_ns_state_spec_low: spec.
