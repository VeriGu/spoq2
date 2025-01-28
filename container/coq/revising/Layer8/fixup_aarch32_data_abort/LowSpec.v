Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_fixup_aarch32_data_abort_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition fixup_aarch32_data_abort_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_type_3")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3, st_0 == ((iasm_get_spsr_el2_spec st));
    if ((v_3 & (16)) =? (0))
    then (Some st_0)
    else (
      when v_6, st_1 == ((load_RData 8 v_1 st_0));
      when st_2 == ((store_RData 8 v_1 (v_6 & (18446744073692774399)) st_1));
      (Some st_2)).

End Layer8_fixup_aarch32_data_abort_LowSpec.

#[global] Hint Unfold fixup_aarch32_data_abort_spec_low: spec.
