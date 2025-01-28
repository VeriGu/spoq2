Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_emulate_stage2_data_abort_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition emulate_stage2_data_abort_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_s_rec_exit")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_5, st_0 == ((load_RData 8 (ptr_offset v_0 32) st));
    when st_1 == ((store_RData 8 (ptr_offset v_1 8) ((v_2 + (4)) |' (2415919104)) st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_1 16) 0 st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_1 24) (v_5 >> (8)) st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_1 32) 0 st_3));
    when v_13, st_5 == ((iasm_get_elr_el2_spec st_4));
    when st_6 == ((iasm_set_elr_el2_spec (v_13 + ((- 4))) st_5));
    (Some st_6).

End Layer8_emulate_stage2_data_abort_LowSpec.

#[global] Hint Unfold emulate_stage2_data_abort_spec_low: spec.
