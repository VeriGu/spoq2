Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_smc_granule_delegate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_delegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if ((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      if ((set_pas_realm_spec_para ((test_PA v_0).(meta_granule_offset)) st_1) =? (0))
      then (
        when st_3_1 == (
            (clear_tte_ns_spec
              v_0
              (st_1.[share] :<
                (((st_1.(share)).[globals].[g_granules] :<
                  ((((st_1.(share)).(globals)).(g_granules)) #
                    ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                    (((((st_1.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 1))).[gpt] :<
                  (((st_1.(share)).(gpt)) # (((test_PA v_0).(meta_granule_offset)) / (4096)) == true)))));
        when v_4, st_2 == ((memset_spec (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) 0 4096 st_3_1));
        when st_6 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
        (Some (0, st_6)))
      else (
        when st_5 == (
            (granule_unlock_spec
              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
              (st_1.[share] :< ((st_1.(share)).[gpt] :< (((st_1.(share)).(gpt)) # (((test_PA v_0).(meta_granule_offset)) / (4096)) == true)))));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

End Layer9_smc_granule_delegate_LowSpec.

#[global] Hint Unfold smc_granule_delegate_spec_low: spec.
