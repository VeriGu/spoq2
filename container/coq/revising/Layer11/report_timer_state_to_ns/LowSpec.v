Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_report_timer_state_to_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition report_timer_state_to_ns_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((iasm_6_spec st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 136) v_2 st_0));
    when v_4, st_2 == ((iasm_136_spec st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 144) v_4 st_2));
    when v_6, st_4 == ((iasm_get_cntvoff_el2_spec st_3));
    when v_7, st_5 == ((load_RData 8 (ptr_offset v_0 144) st_4));
    when st_6 == ((store_RData 8 (ptr_offset v_0 144) (v_7 - (v_6)) st_5));
    when v_9, st_7 == ((iasm_7_spec st_6));
    when st_8 == ((store_RData 8 (ptr_offset v_0 152) v_9 st_7));
    when v_11, st_9 == ((iasm_139_spec st_8));
    when st_10 == ((store_RData 8 (ptr_offset v_0 160) v_11 st_9));
    (Some st_10).

End Layer11_report_timer_state_to_ns_LowSpec.

#[global] Hint Unfold report_timer_state_to_ns_spec_low: spec.
