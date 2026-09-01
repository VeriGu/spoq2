Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_smc_granule_undelegate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_undelegate_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (1)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when st_3 == (
          (set_tte_ns_abs
            v_0
            (st_1.[share] :<
              (((st_1.(share)).[globals].[g_granules] :<
                ((((st_1.(share)).(globals)).(g_granules)) #
                  ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096)) ==
                  (((((st_1.(share)).(globals)).(g_granules)) @ ((((test_PA v_0).(meta_granule_offset)) + (4)) / (4096))).[e_state_s_granule] :< 0))).[gpt] :<
                (((st_1.(share)).(gpt)) # (((test_PA v_0).(meta_granule_offset)) / (4096)) == false)))));
      when st_4 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
      (Some (0, st_4)))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

End Layer9_smc_granule_undelegate_LowSpec.

#[global] Hint Unfold smc_granule_undelegate_spec_low: spec.
