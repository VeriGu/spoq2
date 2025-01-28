Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Spec.
Require Import Layer5.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_validate_ipa_bits_and_sl_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_ipa_bits_and_sl_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (((- 32) + (v_0)) <? (0))
    then (
      when v_6, st_0 == ((make_return_code_spec 2 4 st));
      (Some (v_6, st_0)))
    else (
      if (v_1 >? (3))
      then (
        when v_10, st_0 == ((make_return_code_spec 2 5 st));
        (Some (v_10, st_0)))
      else (
        if (v_1 =? (0))
        then (
          when v_14, st_0 == ((max_pa_size_spec st));
          if (v_14 <? (44))
          then (
            when v_17, st_1 == ((make_return_code_spec 2 5 st_0));
            (Some (v_17, st_1)))
          else (
            when v_20, st_2 == ((s2_inconsistent_sl_spec v_0 v_1 st_0));
            if v_20
            then (
              when v_22, st_3 == ((make_return_code_spec 2 5 st_2));
              (Some (v_22, st_3)))
            else (
              when v_24, st_3 == ((make_return_code_spec 0 0 st_2));
              (Some (v_24, st_3)))))
        else (
          when v_20, st_1 == ((s2_inconsistent_sl_spec v_0 v_1 st));
          if v_20
          then (
            when v_22, st_2 == ((make_return_code_spec 2 5 st_1));
            (Some (v_22, st_2)))
          else (
            when v_24, st_2 == ((make_return_code_spec 0 0 st_1));
            (Some (v_24, st_2)))))).

End Layer11_validate_ipa_bits_and_sl_LowSpec.

#[global] Hint Unfold validate_ipa_bits_and_sl_spec_low: spec.
