Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_affinity_info_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_affinity_info_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    if (v_3 =? (0))
    then (
      when v_9, st_1 == ((vmpidr_to_rec_idx_spec v_2 st_0));
      when v_12_tmp, st_2 == ((load_RData 8 (ptr_offset v_1 944) st_1));
      when v_13, st_3 == ((rd_map_read_rec_count_spec (int_to_ptr v_12_tmp) st_2));
      if ((v_13 - (v_9)) >? (0))
      then (
        when v_18, st_4 == ((load_RData 8 (ptr_offset v_1 8) st_3));
        if ((v_18 - (v_9)) =? (0))
        then (
          when st_5 == ((store_RData 8 (ptr_offset v_0 32) 0 st_4));
          (Some st_5))
        else (
          when st_5 == ((store_RData 1 (ptr_offset v_1 1512) 1 st_4));
          when st_6 == ((store_RData 1 (ptr_offset v_0 0) 1 st_5));
          when st_7 == ((store_RData 8 (ptr_offset v_0 8) v_2 st_6));
          (Some st_7)))
      else (
        when st_4 == ((store_RData 8 (ptr_offset v_0 32) (- 2) st_3));
        (Some st_4)))
    else (
      when st_1 == ((store_RData 8 (ptr_offset v_0 32) (- 2) st_0));
      (Some st_1)).

End Layer7_psci_affinity_info_LowSpec.

#[global] Hint Unfold psci_affinity_info_spec_low: spec.
