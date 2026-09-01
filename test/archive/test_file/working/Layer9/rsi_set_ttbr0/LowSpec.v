Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_set_ttbr0_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_set_ttbr0_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(poffset)) mod (4096)) = (0)) /\ (((v_0.(poffset)) >= (0)))));
    rely (((v_0.(pbase)) = ("granule_data")));
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
    then (
      rely ((((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))));
      rely ((((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (GRANULE_STATE_REC)) = (0)));
      rely ((((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (GRANULE_STATE_REC)) = (0)));
      when st_6 == (
          (granule_unlock_spec
            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
            ((st_1.[priv].[pcpu_regs].[pcpu_ttbr0_el12] :< v_1).[share].[granule_data] :<
              (((st_1.(share)).(granule_data)) #
                ((v_0.(poffset)) / (4096)) ==
                ((((st_1.(share)).(granule_data)) @ (((v_0.(poffset)) + (1536)) / (4096))).[g_norm] :<
                  ((((((st_1.(share)).(granule_data)) @ (((v_0.(poffset)) + (1536)) / (4096))).(g_norm)) #
                    (((v_0.(poffset)) + (1536)) mod (4096)) ==
                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))) #
                    (((v_0.(poffset)) + (392)) mod (4096)) ==
                    v_1))))));
      (Some (0, st_6)))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

End Layer9_rsi_set_ttbr0_LowSpec.

#[global] Hint Unfold rsi_set_ttbr0_spec_low: spec.
