Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_rtt_create_s1_el1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_create_s1_el1_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_6_tmp, st_0 == ((load_RData 8 (ptr_offset v_0 1544) st));
    when st_1 == ((granule_lock_spec (int_to_ptr v_6_tmp) 5 st_0));
    when v_7, st_2 == ((rtt_create_internal_spec (int_to_ptr v_6_tmp) v_1 v_2 v_3 1 st_1));
    (Some (((v_7 << (32)) >> (32)), st_2)).

End Layer8_rtt_create_s1_el1_LowSpec.

#[global] Hint Unfold rtt_create_s1_el1_spec_low: spec.
