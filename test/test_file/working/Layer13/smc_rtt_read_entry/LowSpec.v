Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_read_entry_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_read_entry_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
    rely (((v_3.(pbase)) = ("stack_s_smc_result")));
    rely (((v_3.(poffset)) = (0)));
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when v_14, st_3 == ((validate_rtt_entry_cmds_spec v_1 v_2 (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1));
      if (v_14 =? (0))
      then (
        when ret == (
            (load_r_granule_data_abs
              ((((test_PA v_0).(meta_granule_offset)) + (32)) mod (4096))
              (((st_3.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (32)) / (4096)))));
        when st_2 == ((spinlock_acquire_spec (mkPtr ((test_Z_Ptr ret).(pbase)) ((test_Z_Ptr ret).(poffset))) st_3));
        if (((((((st_2.(share)).(globals)).(g_granules)) @ (((test_Z_Ptr ret).(poffset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
        then (
          when st_8 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
          when rtt_ret, st_9 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr ret) 0 64 v_1 v_2 st_8));
          rely ((((st_9.(share)).(granule_data)) = (((st_8.(share)).(granule_data)))));
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_9).(meta_desc_type)) =? (0)) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_9).(meta_ripas)) =? (0)))) &&
              ((((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_9).(meta_mem_attr)) =? (0)))))
          then (
            when st_20 == ((granule_unlock_spec (rtt_ret.(e_2)) st_9));
            (Some st_20))
          else None)
        else None)
      else None)
    else None.

End Layer13_smc_rtt_read_entry_LowSpec.

#[global] Hint Unfold smc_rtt_read_entry_spec_low: spec.
