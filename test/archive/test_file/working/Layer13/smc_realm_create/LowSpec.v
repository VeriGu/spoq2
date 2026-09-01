Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_realm_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_create_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_7, st_2 == ((memcpy_ns_read_spec (mkPtr "stack_s_realm_params" 0) (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset))) 64 st));
    if v_7
    then (
      when v_9, st_5 == ((validate_realm_params_spec (mkPtr "stack_s_realm_params" 0) st_2));
      if (v_9 =? (0))
      then (
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_5));
        if (
          (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
            (1)) =?
            (0)))
        then (
          rely (
            (((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)) /\
              ((((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
          when st_4 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) 1 st_1));
          rely (((((st_4.(share)).(gpt)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = (true)));
          when st_3 == (
              (granule_unlock_spec
                (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                (st_4.[share].[globals].[g_granules] :<
                  ((((st_4.(share)).(globals)).(g_granules)) #
                    (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                    (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                      5)))));
          when st_6 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
          if (((((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
          then (
            rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            rely (((((((st_6.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            when st_7 == (
                (granule_unlock_spec
                  (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                  (st_6.[share].[globals].[g_granules] :<
                    ((((st_6.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      (((((st_6.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 2)))));
            (Some (0, st_7)))
          else (
            when st_7 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_6));
            if ((0 - ((((st_7.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
            then (
              when st_8 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_7));
              if (
                (((((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                  (5)) =?
                  (0)))
              then (
                rely (
                  ((("granules" = ("granules")) /\ (((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    ((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                rely (((((st_8.(share)).(gpt)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = (true)));
                when st_9 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                      (st_8.[share].[globals].[g_granules] :<
                        ((((st_8.(share)).(globals)).(g_granules)) #
                          (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                          (((((st_8.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                            1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
              else (
                when st_9 == ((spinlock_release_spec (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_8));
                rely (((((st_9.(share)).(gpt)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))) = (true)));
                rely (
                  ((("granules" = ("granules")) /\ (((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) mod (4096)) = (0)))) /\
                    ((((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) >= (0)))));
                when st_10 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)))
                      (st_9.[share].[globals].[g_granules] :<
                        ((((st_9.(share)).(globals)).(g_granules)) #
                          (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096)) ==
                          (((((st_9.(share)).(globals)).(g_granules)) @ (((test_PA (((st_7.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset)) / (4096))).[e_state_s_granule] :<
                            1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_10))))
            else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_7))))
        else (
          when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA (((st_5.(stack)).(stack_s_realm_params)).(e_rtt_addr))).(meta_granule_offset))) st_1));
          (Some ((pack_struct_return_code_para 1), st_3))))
      else (Some (v_9, st_5)))
    else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)).

End Layer13_smc_realm_create_LowSpec.

#[global] Hint Unfold smc_realm_create_spec_low: spec.
