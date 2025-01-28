Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_cpu_suspend_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_cpu_suspend_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when st_1 == ((store_RData 1 (ptr_offset v_0 0) 1 st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 32) 0 st_1));
    (Some st_2).

End Layer7_psci_cpu_suspend_LowSpec.

#[global] Hint Unfold psci_cpu_suspend_spec_low: spec.
