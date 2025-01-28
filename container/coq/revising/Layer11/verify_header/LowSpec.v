Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_verify_header_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition verify_header_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 0) st));
    if (v_3 =? (4278233685))
    then (
      when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 56) st_0));
      if (v_7 =? (3994130790))
      then (
        when v_11, st_2 == ((load_RData 8 (ptr_offset v_0 16) st_1));
        if (v_11 >? (1))
        then (Some (1, st_2))
        else (
          when v_16_tmp, st_3 == ((load_RData 8 (ptr_offset v_0 24) st_2));
          if (ptr_eqb (int_to_ptr v_16_tmp) (mkPtr "null" 0))
          then (
            when v_24_tmp, st_5 == ((load_RData 8 (ptr_offset v_0 40) st_3));
            if (ptr_eqb (int_to_ptr v_24_tmp) (mkPtr "null" 0))
            then (Some (0, st_5))
            else (
              when v_27_tmp, st_6 == ((load_RData 8 (ptr_offset v_0 48) st_5));
              if (ptr_eqb (int_to_ptr v_24_tmp) (int_to_ptr v_27_tmp))
              then (Some (1, st_6))
              else (Some (0, st_6))))
          else (
            when v_19_tmp, st_4 == ((load_RData 8 (ptr_offset v_0 32) st_3));
            if (ptr_eqb (int_to_ptr v_16_tmp) (int_to_ptr v_19_tmp))
            then (Some (1, st_4))
            else (
              when v_24_tmp, st_6 == ((load_RData 8 (ptr_offset v_0 40) st_4));
              if (ptr_eqb (int_to_ptr v_24_tmp) (mkPtr "null" 0))
              then (Some (0, st_6))
              else (
                when v_27_tmp, st_7 == ((load_RData 8 (ptr_offset v_0 48) st_6));
                if (ptr_eqb (int_to_ptr v_24_tmp) (int_to_ptr v_27_tmp))
                then (Some (1, st_7))
                else (Some (0, st_7)))))))
      else (Some (1, st_1)))
    else (Some (1, st_0)).

End Layer11_verify_header_LowSpec.

#[global] Hint Unfold verify_header_spec_low: spec.
