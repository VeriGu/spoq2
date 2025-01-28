Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_cpu_on_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_cpu_on_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    when v_8, st_1 == ((load_RData 8 (ptr_offset v_1 920) st_0));
    if ((v_8 - (v_3)) >? (0))
    then (
      when st_3 == ((store_RData 8 (ptr_offset v_0 32) (- 9) st_1));
      (Some st_3))
    else (
      when v_12, st_2 == ((load_RData 8 (ptr_offset v_1 936) st_1));
      if ((v_12 - (v_3)) >? (0))
      then (
        when v_16, st_3 == ((vmpidr_to_rec_idx_spec v_2 st_2));
        when v_19_tmp, st_4 == ((load_RData 8 (ptr_offset v_1 944) st_3));
        when v_20, st_5 == ((rd_map_read_rec_count_spec (int_to_ptr v_19_tmp) st_4));
        if ((v_20 - (v_16)) >? (0))
        then (
          when v_25, st_6 == ((load_RData 8 (ptr_offset v_1 8) st_5));
          if ((v_25 - (v_16)) =? (0))
          then (
            when st_7 == ((store_RData 8 (ptr_offset v_0 32) (- 4) st_6));
            (Some st_7))
          else (
            when st_7 == ((store_RData 1 (ptr_offset v_1 1512) 1 st_6));
            when st_8 == ((store_RData 1 (ptr_offset v_0 0) 1 st_7));
            when st_9 == ((store_RData 8 (ptr_offset v_0 8) v_2 st_8));
            (Some st_9)))
        else (
          when st_6 == ((store_RData 8 (ptr_offset v_0 32) (- 2) st_5));
          (Some st_6)))
      else (
        when st_5 == ((store_RData 8 (ptr_offset v_0 32) (- 9) st_2));
        (Some st_5))).

End Layer7_psci_cpu_on_LowSpec.

#[global] Hint Unfold psci_cpu_on_spec_low: spec.
