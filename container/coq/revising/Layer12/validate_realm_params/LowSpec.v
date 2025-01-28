Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_validate_realm_params_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_realm_params_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 56) st));
    if (v_3 =? (0))
    then (
      when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 0) st_0));
      if ((v_7 & (4095)) =? (0))
      then (
        when v_12, st_2 == ((load_RData 8 (ptr_offset v_0 8) st_1));
        if ((v_12 & (4095)) =? (0))
        then (
          when v_19, st_3 == ((load_RData 8 (ptr_offset v_0 32) st_2));
          when v_20, st_4 == ((validate_rmm_feature_register_value_spec 0 v_19 st_3));
          if v_20
          then (
            when v_24, st_5 == ((requested_ipa_bits_spec v_0 st_4));
            when v_26, st_6 == ((load_RData 8 (ptr_offset v_0 40) st_5));
            when v_27, st_7 == ((validate_ipa_bits_and_sl_spec v_24 v_26 st_6));
            if (v_27 =? (0))
            then (
              when v_31, st_8 == ((requested_ipa_bits_spec v_0 st_7));
              when v_32, st_9 == ((load_RData 8 (ptr_offset v_0 40) st_8));
              when v_34, st_10 == ((s2_num_root_rtts_spec v_31 v_32 st_9));
              when v_36, st_11 == ((load_RData 4 (ptr_offset v_0 48) st_10));
              if ((v_34 - (v_36)) =? (0))
              then (
                when v_40, st_12 == ((requested_ipa_bits_spec v_0 st_11));
                when v_41, st_13 == ((load_RData 8 (ptr_offset v_0 0) st_12));
                when v_42, st_14 == ((load_RData 8 (ptr_offset v_0 8) st_13));
                if (((v_42 + (v_41)) - (v_41)) >? (0))
                then (
                  if (((v_42 + (v_41)) >> (v_40)) =? (0))
                  then (
                    when v_50, st_15 == ((load_RData 8 (ptr_offset v_0 24) st_14));
                    if ((v_50 =? (0)) || ((v_50 =? (1))))
                    then (
                      when v_55, st_17 == ((load_RData 4 (ptr_offset v_0 52) st_15));
                      when v_56, st_18 == ((vmid_reserve_spec v_55 st_17));
                      if v_56
                      then (Some (0, st_18))
                      else (
                        when v_58, st_19 == ((pack_return_code_spec 2 7 st_18));
                        (Some (v_58, st_19))))
                    else (
                      when v_52, st_16 == ((pack_return_code_spec 2 3 st_15));
                      (Some (v_52, st_16))))
                  else (
                    when v_47, st_16 == ((pack_return_code_spec 2 0 st_14));
                    (Some (v_47, st_16))))
                else (
                  when v_47, st_16 == ((pack_return_code_spec 2 0 st_14));
                  (Some (v_47, st_16))))
              else (
                when v_38, st_12 == ((pack_return_code_spec 2 6 st_11));
                (Some (v_38, st_12))))
            else (
              when v_29, st_8 == ((pack_struct_return_code_spec v_27 st_7));
              (Some (v_29, st_8))))
          else (
            when v_22, st_5 == ((pack_return_code_spec 2 0 st_4));
            (Some (v_22, st_5))))
        else (
          when v_16, st_4 == ((pack_return_code_spec 2 0 st_2));
          (Some (v_16, st_4))))
      else (
        when v_16, st_3 == ((pack_return_code_spec 2 0 st_1));
        (Some (v_16, st_3))))
    else (Some (0, st_0)).

End Layer12_validate_realm_params_LowSpec.

#[global] Hint Unfold validate_realm_params_spec_low: spec.
