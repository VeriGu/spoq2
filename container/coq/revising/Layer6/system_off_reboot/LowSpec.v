Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_system_off_reboot_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition system_off_reboot_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3_tmp, st_0 == ((load_RData 8 (ptr_offset v_0 944) st));
    when st_1 == ((granule_lock_spec (int_to_ptr v_3_tmp) 2 st_0));
    when v_4_tmp, st_2 == ((load_RData 8 (ptr_offset v_0 944) st_1));
    when v_5, st_3 == ((granule_map_spec (int_to_ptr v_4_tmp) 2 st_2));
    when st_4 == ((set_rd_state_spec v_5 2 st_3));
    when st_5 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_4));
    (Some st_5).

End Layer6_system_off_reboot_LowSpec.

#[global] Hint Unfold system_off_reboot_spec_low: spec.
