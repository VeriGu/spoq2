Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_cpu_off_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_cpu_off_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely ((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
    rely ((((st_1.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
    when st_3 == ((store_RData 1 (mkPtr (v_0.(pbase)) (v_0.(poffset))) 1 st_1));
    when st_4 == ((store_RData 1 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (16))) 0 st_3));
    when st_5 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) 0 st_4));
    (Some st_5).

End Layer7_psci_cpu_off_LowSpec.

#[global] Hint Unfold psci_cpu_off_spec_low: spec.
