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
    when v_3_tmp, st_0 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (944))) st));
    when st_1 == ((granule_lock_spec (int_to_ptr v_3_tmp) 2 st_0));
    when v_4_tmp, st_2 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (944))) st_1));
    rely (((((((st_2.(share)).(granule_data)) @ (((int_to_ptr v_4_tmp).(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (("granule_data" = ("granule_data")));
    when st_6 == ((store_RData 64 (mkPtr "granule_data" ((int_to_ptr v_4_tmp).(poffset))) 2 st_2));
    when st_8 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_6));
    (Some st_8).

End Layer6_system_off_reboot_LowSpec.

#[global] Hint Unfold system_off_reboot_spec_low: spec.
