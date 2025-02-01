Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_version_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_version_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
    rely ((((st_1.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
    when st_3 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) 65537 st_1));
    (Some st_3).

End Layer7_psci_version_LowSpec.

#[global] Hint Unfold psci_version_spec_low: spec.
