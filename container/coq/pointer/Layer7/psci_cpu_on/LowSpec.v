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
    when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr (v_0.(pbase)) (v_0.(poffset))) 0 64 false st));
    rely ((((st_1.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
    when v_8, st_3 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (920))) st_1));
    if ((v_8 - (v_3)) >? (0))
    then (
      when st_4 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) (- 9) st_3));
      (Some st_4))
    else (
      when v_12, st_4 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (936))) st_3));
      if ((v_12 - (v_3)) >? (0))
      then (
        when v_19_tmp, st_6 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (944))) st_4));
        rely ((((((int_to_ptr v_19_tmp).(pbase)) = ("granules")) /\ (((((int_to_ptr v_19_tmp).(poffset)) mod (16)) = (0)))) /\ ((((int_to_ptr v_19_tmp).(poffset)) >= (0)))));
        rely (((((((st_6.(share)).(granule_data)) @ (((int_to_ptr v_19_tmp).(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        rely (("granule_data" = ("granule_data")));
        when v_6, st_5 == ((load_RData 64 (mkPtr "granule_data" (((int_to_ptr v_19_tmp).(poffset)) + (8))) st_6));
        if ((v_6 - ((((((v_2 >> (4)) & (4080)) |' ((v_2 & (15)))) |' (((v_2 >> (4)) & (1044480)))) |' (((v_2 >> (12)) & (267386880)))))) >? (0))
        then (
          when v_25, st_8 == ((load_RData 8 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (8))) st_5));
          if ((v_25 - ((((((v_2 >> (4)) & (4080)) |' ((v_2 & (15)))) |' (((v_2 >> (4)) & (1044480)))) |' (((v_2 >> (12)) & (267386880)))))) =? (0))
          then (
            when st_9 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) (- 4) st_8));
            (Some st_9))
          else (
            when st_9 == ((store_RData 1 (mkPtr (v_1.(pbase)) ((v_1.(poffset)) + (1512))) 1 st_8));
            when st_10 == ((store_RData 1 (mkPtr (v_0.(pbase)) (v_0.(poffset))) 1 st_9));
            when st_11 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) v_2 st_10));
            (Some st_11)))
        else (
          when st_8 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) (- 2) st_5));
          (Some st_8)))
      else (
        when st_5 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) (- 9) st_4));
        (Some st_5))).

End Layer7_psci_cpu_on_LowSpec.

#[global] Hint Unfold psci_cpu_on_spec_low: spec.
