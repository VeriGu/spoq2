Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_save_ns_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition save_ns_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((save_sysreg_state_spec (ptr_offset v_0 0) st));
    when v_3, st_1 == ((iasm_get_cnthctl_el2_spec st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 248) v_3 st_1));
    when v_5, st_3 == ((iasm_207_spec st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 560) v_5 st_3));
    (Some st_4).

End Layer11_save_ns_state_LowSpec.

#[global] Hint Unfold save_ns_state_spec_low: spec.
