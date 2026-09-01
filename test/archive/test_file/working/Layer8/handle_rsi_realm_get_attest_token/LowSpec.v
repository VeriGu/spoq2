Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_handle_rsi_realm_get_attest_token_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition handle_rsi_realm_get_attest_token_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((v_0.(pbase)) = ("stack_s_attest_result")));
    rely (((v_0.(poffset)) = (0)));
    rely ((((((((st.(share)).(globals)).(g_granules)) @ ((v_1.(poffset)) / (4096))).(e_state_s_granule)) - (GRANULE_STATE_REC)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    if ((((((st.(share)).(granule_data)) @ (((v_1.(poffset)) + (40)) / (4096))).(g_norm)) @ (((v_1.(poffset)) + (40)) mod (4096))) >? (4096))
    then (
      (Some ((st.[stack].[stack_s_attest_result] :<
        ((((st.(stack)).(stack_s_attest_result)).[e_return_to_realm] :< 1).[e_smc_result] :<
          ((((st.(stack)).(stack_s_attest_result)).(e_smc_result)).[e_x0] :< (pack_struct_return_code_para (make_return_code_para 1))))).[stack].[stack_type_4] :<
        0)))
    else (
      if ((((((st.(share)).(granule_data)) @ (((v_1.(poffset)) + (48)) / (4096))).(g_norm)) @ (((v_1.(poffset)) + (48)) mod (4096))) =? (64))
      then (
        if (
          (((((((st.(share)).(globals)).(g_rmm_platform_token)).(e_len_s_q_useful_buf)) + ((((st.(stack)).(stack_s_q_useful_buf__3)).(e_len_s_q_useful_buf)))) -
            ((((((st.(share)).(granule_data)) @ (((v_1.(poffset)) + (40)) / (4096))).(g_norm)) @ (((v_1.(poffset)) + (40)) mod (4096))))) >?
            (0)))
        then (
          (Some ((st.[stack].[stack_s_attest_result] :<
            ((((st.(stack)).(stack_s_attest_result)).[e_return_to_realm] :< 1).[e_smc_result] :<
              ((((st.(stack)).(stack_s_attest_result)).(e_smc_result)).[e_x0] :< (pack_struct_return_code_para (make_return_code_para 1))))).[stack].[stack_type_4] :<
            0)))
        else (
          (Some ((st.[stack].[stack_s_attest_result] :<
            ((((st.(stack)).(stack_s_attest_result)).[e_return_to_realm] :< 1).[e_smc_result] :<
              (((((st.(stack)).(stack_s_attest_result)).(e_smc_result)).[e_x0] :< 0).[e_x1] :<
                (((((st.(share)).(globals)).(g_rmm_platform_token)).(e_len_s_q_useful_buf)) + ((((st.(stack)).(stack_s_q_useful_buf__3)).(e_len_s_q_useful_buf))))))).[stack].[stack_type_4] :<
            0))))
      else (
        (Some ((st.[stack].[stack_s_attest_result] :<
          ((((st.(stack)).(stack_s_attest_result)).[e_return_to_realm] :< 1).[e_smc_result] :<
            ((((st.(stack)).(stack_s_attest_result)).(e_smc_result)).[e_x0] :< (pack_struct_return_code_para (make_return_code_para 1))))).[stack].[stack_type_4] :<
          0)))).

End Layer8_handle_rsi_realm_get_attest_token_LowSpec.

#[global] Hint Unfold handle_rsi_realm_get_attest_token_spec_low: spec.
