Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_system_off_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_system_off_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
    rely ((((st_1.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
    rely (((((((st_1.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    when v_3_tmp, st_4 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (944))) st_1));
    when st_5 == ((granule_lock_spec (int_to_ptr v_3_tmp) 2 st_4));
    when v_4_tmp, st_6 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (944))) st_5));
    rely (((((((st_6.(share)).(granule_data)) @ (((int_to_ptr v_4_tmp).(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (("granule_data" = ("granule_data")));
    when st_7 == ((store_RData 64 (mkPtr "granule_data" ((int_to_ptr v_4_tmp).(poffset))) 2 st_6));
    when st_8 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_7));
    when st_10 == ((store_RData 1 (mkPtr (v_0.(pbase)) (v_0.(poffset))) 1 st_8));
    (Some st_10).

End Layer7_psci_system_off_LowSpec.

#[global] Hint Unfold psci_system_off_spec_low: spec.
