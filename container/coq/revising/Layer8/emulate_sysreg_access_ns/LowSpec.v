Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_emulate_sysreg_access_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition emulate_sysreg_access_ns_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_s_rec_exit")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    if ((v_2 & (1)) =? (0))
    then (
      when v_6, st_0 == ((get_sysreg_write_value_spec v_0 v_2 st));
      when st_1 == ((store_RData 8 (ptr_offset v_1 32) v_6 st_0));
      (Some st_1))
    else (Some st).

End Layer8_emulate_sysreg_access_ns_LowSpec.

#[global] Hint Unfold emulate_sysreg_access_ns_spec_low: spec.
