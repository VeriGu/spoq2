Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_1).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
      when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) 0 64 v_2 (v_3 + ((- 1))) st_1));
      if (((ret_rtt.(e_1)) - ((v_3 + ((- 1))))) =? (0))
      then (
        rely ((((ret_rtt.(e_3)) < (512)) /\ (((ret_rtt.(e_3)) >= (0)))));
        if (((v_3 + ((- 1))) <? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_desc_type)) =? (3))))
        then (
          if (
            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_2).(meta_PA)).(meta_granule_offset)) -
              (((test_PA v_0).(meta_granule_offset)))) =?
              (0)))
          then (
            when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
            if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (5)) =? (0))
            then (
              rely ((((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
              if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3) =? (0))
              then (
                rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (16)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                when v_5, st_4 == (
                    (memset_spec
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      0
                      4096
                      ((st_3.[share].[globals].[g_granules] :<
                        ((((st_3.(share)).(globals)).(g_granules)) #
                          (((ret_rtt.(e_2)).(poffset)) / (16)) ==
                          (((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).[e_ref] :<
                            ((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                              (((((((st_3.(share)).(globals)).(g_granules)) @ (((ret_rtt.(e_2)).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                        (((st_3.(share)).(granule_data)) #
                          ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                          ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                            (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                              (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                when st_24 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                      (st_4.[share].[globals].[g_granules] :<
                        ((((st_4.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                          (((((st_4.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
                when st_28 == ((granule_unlock_spec (ret_rtt.(e_2)) st_24));
                (Some (0, st_28)))
              else (
                when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_3));
                when st_18 == ((granule_unlock_spec (ret_rtt.(e_2)) st_14));
                (Some ((pack_struct_return_code_para (make_return_code_para 4)), st_18))))
            else None)
          else (
            when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
            (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))
        else (
          when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
          (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_12))))
      else (
        when st_7 == ((granule_unlock_spec (ret_rtt.(e_2)) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_7))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

End Layer9_rsi_rtt_destroy_LowSpec.

#[global] Hint Unfold rsi_rtt_destroy_spec_low: spec.
