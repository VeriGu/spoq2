Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_realm_activate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_activate_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((query_oracle st));
    when st_1 == ((query_oracle st_0));
    match (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_lock)).(e_val))) with
    | None =>
      if (
        ((((((((st_1.(share)).(globals)).(g_granules)) #
          (((test_PA v_0).(meta_granule_offset)) / (16)) ==
          (((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
          (2)) =?
          (0)))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        rely (((((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        if ((((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
        then (
          (Some (
            0  ,
            (st_1.[share].[granule_data] :<
              (((st_1.(share)).(granule_data)) #
                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                ((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                  (((((st_1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) # (((test_PA v_0).(meta_granule_offset)) mod (4096)) == 1))))
          )))
        else (
          (Some (
            (pack_struct_return_code_para (make_return_code_para 5))  ,
            (st_1.[share].[globals].[g_granules] :<
              ((((st_1.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                (((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))
          ))))
      else (
        when st_2 == ((query_oracle st_1));
        (Some (
          (pack_struct_return_code_para (make_return_code_para 1))  ,
          (st_2.[share].[globals].[g_granules] :<
            ((((st_2.(share)).(globals)).(g_granules)) #
              (((test_PA v_0).(meta_granule_offset)) / (16)) ==
              (((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_lock].[e_val] :< None)))
        )))
    | (Some cid) => None
    end.

End Layer13_smc_realm_activate_LowSpec.

#[global] Hint Unfold smc_realm_activate_spec_low: spec.
