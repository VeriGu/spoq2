Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_psci_features_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_features_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    when st_0 == ((llvm_memset_p0i8_i64_spec (ptr_offset v_0 0) 0 64 false st));
    if (
      ((((((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
        ((v_2 =? (3288334340)))) ||
        ((v_2 =? (2214592520)))) ||
        ((v_2 =? (2214592521)))) ||
        ((v_2 =? (2214592522)))))
    then (
      if (
        (((((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
          ((v_2 =? (3288334340)))) ||
          ((v_2 =? (2214592520)))) ||
          ((v_2 =? (2214592521)))))
      then (
        if (
          ((((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
            ((v_2 =? (3288334340)))) ||
            ((v_2 =? (2214592520)))))
        then (
          if (
            (((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516)))) ||
              ((v_2 =? (3288334340)))))
          then (
            if ((((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339)))) || ((v_2 =? (2214592516))))
            then (
              if (((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515)))) || ((v_2 =? (3288334339))))
              then (
                if ((((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592515))))
                then (
                  if (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))) || ((v_2 =? (2214592514))))
                  then (
                    when st_11 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                    (Some st_11))
                  else (
                    when st_10 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                    (Some st_10)))
                else (
                  when st_9 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                  (Some st_9)))
              else (
                when st_8 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
                (Some st_8)))
            else (
              when st_7 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
              (Some st_7)))
          else (
            when st_6 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
            (Some st_6)))
        else (
          when st_5 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
          (Some st_5)))
      else (
        when st_4 == ((store_RData 8 (ptr_offset v_0 32) 0 st_0));
        (Some st_4)))
    else (
      when st_2 == ((store_RData 8 (ptr_offset v_0 32) (- 1) st_0));
      (Some st_2)).

End Layer7_psci_features_LowSpec.

#[global] Hint Unfold psci_features_spec_low: spec.
