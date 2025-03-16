Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_handle_rsi_realm_extend_measurement_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition handle_rsi_realm_extend_measurement_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (4096))).(e_state_s_granule)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when st_1 == ((spinlock_acquire_spec (mkPtr ((rec_to_rd_para v_0 st).(pbase)) ((rec_to_rd_para v_0 st).(poffset))) st));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para v_0 st).(poffset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
    then (
      if ((((((((st_1.(share)).(granule_data)) @ (((v_0.(poffset)) + (32)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (32)) mod (4096))) + ((- 7))) - ((- 6))) <? (0))
      then (
        when st_9 == ((granule_unlock_spec (rec_to_rd_para v_0 st_1) st_1));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
      else (
        if ((((((st_1.(share)).(granule_data)) @ (((v_0.(poffset)) + (40)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (40)) mod (4096))) >? (64))
        then (
          when st_11 == ((granule_unlock_spec (rec_to_rd_para v_0 st_1) st_1));
          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_11)))
        else (
          when v_29, st_7 == (
              (memcpy_spec
                (mkPtr "stack_type_8" 0)
                (mkPtr
                  "granule_data"
                  ((((rec_to_rd_para v_0 st_1).(poffset)) + (184)) +
                    ((32 * (((((((st_1.(share)).(granule_data)) @ (((v_0.(poffset)) + (32)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (32)) mod (4096))) & (4294967295)))))))
                32
                st_1));
          when v_31, st_8 == (
              (memcpy_spec
                (mkPtr "stack_type_8" 32)
                (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (48)))
                (((((st_1.(share)).(granule_data)) @ (((v_0.(poffset)) + (40)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (40)) mod (4096)))
                st_7));
          when st_12 == ((granule_unlock_spec (rec_to_rd_para v_0 st_8) st_8));
          (Some (0, st_12)))))
    else (
      when st_2 == ((spinlock_release_spec (mkPtr ((rec_to_rd_para v_0 st).(pbase)) ((rec_to_rd_para v_0 st).(poffset))) st_1));
      if ((((((((st_2.(share)).(granule_data)) @ (((v_0.(poffset)) + (32)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (32)) mod (4096))) + ((- 7))) - ((- 6))) <? (0))
      then (
        when st_9 == ((granule_unlock_spec (rec_to_rd_para v_0 st_2) st_2));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9)))
      else (
        if ((((((st_2.(share)).(granule_data)) @ (((v_0.(poffset)) + (40)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (40)) mod (4096))) >? (64))
        then (
          when st_11 == ((granule_unlock_spec (rec_to_rd_para v_0 st_2) st_2));
          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_11)))
        else (
          when v_29, st_7 == (
              (memcpy_spec
                (mkPtr "stack_type_8" 0)
                (mkPtr
                  "granule_data"
                  ((((rec_to_rd_para v_0 st_2).(poffset)) + (184)) +
                    ((32 * (((((((st_2.(share)).(granule_data)) @ (((v_0.(poffset)) + (32)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (32)) mod (4096))) & (4294967295)))))))
                32
                st_2));
          when v_31, st_8 == (
              (memcpy_spec
                (mkPtr "stack_type_8" 32)
                (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (48)))
                (((((st_2.(share)).(granule_data)) @ (((v_0.(poffset)) + (40)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (40)) mod (4096)))
                st_7));
          when st_12 == ((granule_unlock_spec (rec_to_rd_para v_0 st_8) st_8));
          (Some (0, st_12))))).

End Layer8_handle_rsi_realm_extend_measurement_LowSpec.

#[global] Hint Unfold handle_rsi_realm_extend_measurement_spec_low: spec.
