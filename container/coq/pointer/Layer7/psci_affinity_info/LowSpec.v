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
    when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
    rely ((((st_1.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
    if (v_3 =? (0))
    then (
      when v_12_tmp, st_5 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (944))) st_1));
      rely ((((((int_to_ptr v_12_tmp).(pbase)) = ("granules")) /\ (((((int_to_ptr v_12_tmp).(poffset)) mod (16)) = (0)))) /\ ((((int_to_ptr v_12_tmp).(poffset)) >= (0)))));
      rely (((((((st_5.(share)).(granule_data)) @ (((int_to_ptr v_12_tmp).(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
      rely (("granule_data" = ("granule_data")));
      when v_5, st_3 == ((load_RData 64 (mkPtr "granule_data" (((int_to_ptr v_12_tmp).(poffset)) + (8))) st_5));
      if ((v_5 - ((((((v_2 >> (4)) & (4080)) |' ((v_2 & (15)))) |' (((v_2 >> (4)) & (1044480)))) |' (((v_2 >> (12)) & (267386880)))))) >? (0))
      then (
        when v_18, st_7 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (8))) st_3));
        if ((v_18 - ((((((v_2 >> (4)) & (4080)) |' ((v_2 & (15)))) |' (((v_2 >> (4)) & (1044480)))) |' (((v_2 >> (12)) & (267386880)))))) =? (0))
        then (
          when st_8 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) 0 st_7));
          (Some st_8))
        else (
          when st_8 == ((store_RData 1 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (1512))) 1 st_7));
          when st_9 == ((store_RData 1 (mkPtr (v_0.(pbase)) (v_0.(poffset))) 1 st_8));
          when st_10 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) v_2 st_9));
          (Some st_10)))
      else (
        when st_7 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) (- 2) st_3));
        (Some st_7)))
    else (
      when st_3 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) (- 2) st_1));
      (Some st_3)).

End Layer7_psci_affinity_info_LowSpec.

#[global] Hint Unfold psci_affinity_info_spec_low: spec.
