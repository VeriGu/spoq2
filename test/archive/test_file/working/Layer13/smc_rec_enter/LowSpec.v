Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rec_enter_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rec_enter_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) =? (GRANULE_STATE_REC)));
    rely (((((test_PA v_0).(meta_granule_offset)) mod (4096)) =? (0)));
    if (check_rcsm_mask_para (test_PA v_0))
    then (
      if (
        ((((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1528)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1528)) mod (4096))) =?
          (0)))
      then (
        when st_13 == (
            (rcsm_restore_pico_state_spec
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              ((((st.[priv].[pcpu_regs].[pcpu_sctlr_el12] :<
                (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (360)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (360)) mod (4096)))).[priv].[pcpu_regs].[pcpu_tcr_el12] :<
                (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (408)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (408)) mod (4096)))).[priv].[pcpu_regs].[pcpu_vbar_el12] :<
                (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (456)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (456)) mod (4096)))).[share].[granule_data] :<
                (((((st.(share)).(granule_data)) #
                  ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                  ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                    (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                      CPU_ID))) #
                  ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096)) ==
                  (((((st.(share)).(granule_data)) #
                    ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                    ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                      (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                        CPU_ID))) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).[g_norm] :<
                    ((((((st.(share)).(granule_data)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                      ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                        (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                          ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                          CPU_ID))) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)) ==
                      v_1))) #
                  ((((test_PA v_0).(meta_granule_offset)) + (1528)) / (4096)) ==
                  ((((((st.(share)).(granule_data)) #
                    ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                    ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                      (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                        CPU_ID))) #
                    ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096)) ==
                    (((((st.(share)).(granule_data)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                      ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                        (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                          ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                          CPU_ID))) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).[g_norm] :<
                      ((((((st.(share)).(granule_data)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                        ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                          (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                            ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                            CPU_ID))) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)) ==
                        v_1))) @ ((((test_PA v_0).(meta_granule_offset)) + (1528)) / (4096))).[g_norm] :<
                    (((((((st.(share)).(granule_data)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                      ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                        (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                          ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                          CPU_ID))) #
                      ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096)) ==
                      (((((st.(share)).(granule_data)) #
                        ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                        ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                          (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                            ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                            CPU_ID))) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).[g_norm] :<
                        ((((((st.(share)).(granule_data)) #
                          ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096)) ==
                          ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).[g_norm] :<
                            (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) #
                              ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)) ==
                              CPU_ID))) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) #
                          ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)) ==
                          v_1))) @ ((((test_PA v_0).(meta_granule_offset)) + (1528)) / (4096))).(g_norm)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (1528)) mod (4096)) ==
                      1))))));
        when v_28, st_4 == ((run_realm_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (24))) st_13));
        when v_29, st_6 == (
            (handle_pico_rec_exit_spec
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (24)))
              st_4));
        when st_19 == (
            (rcsm_save_pico_state_spec
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (st_6.[stack].[stack_s_smc_result] :<
                ((((((st_6.(stack)).(stack_s_smc_result)).[e_x0] :<
                  (((((st_6.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))).[e_x1] :<
                  (((((st_6.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)))).[e_x2] :<
                  (((((st_6.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (40)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (40)) mod (4096)))).[e_x3] :<
                  (((((st_6.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (48)) mod (4096)))))));
        (Some (st_19.[priv].[pcpu_regs].[pcpu_ich_hcr_el2] :< (((st.(priv)).(pcpu_regs)).(pcpu_ich_hcr_el2)))))
      else (
        rely (((((test_PA v_0).(meta_granule_offset)) mod (4096)) =? (0)));
        rely (((((((st.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) =? (GRANULE_STATE_REC)));
        when st_5 == (
            (rcsm_restore_pico_state_spec
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (st.[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096)) ==
                  ((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).[g_norm] :<
                    (((((st.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) #
                      ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)) ==
                      CPU_ID))))));
        when v_28, st_3 == ((run_realm_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (24))) st_5));
        when v_29, st_4 == (
            (handle_pico_rec_exit_spec
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (24)))
              st_3));
        when st_14 == (
            (rcsm_save_pico_state_spec
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (st_4.[stack].[stack_s_smc_result] :<
                ((((((st_4.(stack)).(stack_s_smc_result)).[e_x0] :<
                  (((((st_4.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (24)) mod (4096)))).[e_x1] :<
                  (((((st_4.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096)))).[e_x2] :<
                  (((((st_4.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (40)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (40)) mod (4096)))).[e_x3] :<
                  (((((st_4.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (48)) mod (4096)))))));
        (Some (st_14.[priv].[pcpu_regs].[pcpu_ich_hcr_el2] :< (((st.(priv)).(pcpu_regs)).(pcpu_ich_hcr_el2))))))
    else (Some st).

End Layer13_smc_rec_enter_LowSpec.

#[global] Hint Unfold smc_rec_enter_spec_low: spec.
