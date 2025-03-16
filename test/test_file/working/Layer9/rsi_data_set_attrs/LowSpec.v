Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_set_attrs_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_set_attrs_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when rtt_ret, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) 0 64 v_1 3 st_1));
      rely (((((((st_2.(share)).(globals)).(g_granules)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(e_state_s_granule)) = (GRANULE_STATE_RTT)));
      if ((rtt_ret.(e_1)) =? (3))
      then (
        when st_19 == (
            (granule_unlock_spec
              (rtt_ret.(e_2))
              (st_2.[share].[granule_data] :<
                (((st_2.(share)).(granule_data)) #
                  ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096)) ==
                  ((((st_2.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).[g_norm] :<
                    (((((st_2.(share)).(granule_data)) @ ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) / (4096))).(g_norm)) #
                      ((((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3)))))) mod (4096)) ==
                      (test_PTE_Z
                        (mkabs_PTE_t
                          ((abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_2).(meta_PA))
                          (abs_attr_to_desc_type v_2)
                          (abs_attr_to_ripas v_2)
                          (abs_attr_to_mem_attr v_2)))))))));
        (Some (0, st_19)))
      else (
        when st_7 == ((granule_unlock_spec (rtt_ret.(e_2)) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

End Layer9_rsi_data_set_attrs_LowSpec.

#[global] Hint Unfold rsi_data_set_attrs_spec_low: spec.
