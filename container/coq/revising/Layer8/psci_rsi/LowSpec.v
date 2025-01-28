Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_psci_rsi_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_rsi_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    if (
      (((((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522)))) ||
        (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))))) ||
        (((v_2 =? (2214592515)) || ((v_2 =? (3288334339)))))))
    then (
      if (
        ((((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522)))) ||
          (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))))))
      then (
        if (((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522))))
        then (
          if ((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521))))
          then (
            if (((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520))))
            then (
              if ((v_2 =? (2214592512)) || ((v_2 =? (2214592514))))
              then (
                if (v_2 =? (2214592512))
                then (
                  when st_0 == ((store_RData 8 (ptr_offset v_0 32) (- 1) st));
                  when st_1 == ((store_RData 1 (ptr_offset v_0 0) 0 st_0));
                  (Some st_1))
                else (
                  when st_0 == ((psci_version_spec v_0 v_1 st));
                  (Some st_0)))
              else (
                when st_0 == ((psci_cpu_off_spec v_0 v_1 st));
                (Some st_0)))
            else (
              when st_0 == ((psci_system_off_spec v_0 v_1 st));
              (Some st_0)))
          else (
            when st_0 == ((psci_system_reset_spec v_0 v_1 st));
            (Some st_0)))
        else (
          when st_0 == ((psci_features_spec v_0 v_1 v_3 st));
          (Some st_0)))
      else (
        when st_1 == ((psci_cpu_suspend_spec v_0 v_1 v_3 v_4 st));
        (Some st_1)))
    else (
      if ((v_2 =? (2214592516)) || ((v_2 =? (3288334340))))
      then (
        when st_1 == ((psci_affinity_info_spec v_0 v_1 (v_3 & (4294967295)) (v_4 & (4294967295)) st));
        (Some st_1))
      else (
        when st_1 == ((psci_affinity_info_spec v_0 v_1 v_3 v_4 st));
        (Some st_1))).

End Layer8_psci_rsi_LowSpec.

#[global] Hint Unfold psci_rsi_spec_low: spec.
