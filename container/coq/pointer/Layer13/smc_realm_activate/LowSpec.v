Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_realm_activate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_activate_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (2)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))));
      rely (((((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
      if ((((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
      then (
        when st_6 == (
            (granule_unlock_spec
              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
              (st_1.[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  ((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                    (((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) # (((test_PA v_0).(meta_granule_offset)) mod (4096)) == 1))))));
        (Some (0, st_6)))
      else (
        when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 5)), st_5))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

End Layer13_smc_realm_activate_LowSpec.

#[global] Hint Unfold smc_realm_activate_spec_low: spec.
