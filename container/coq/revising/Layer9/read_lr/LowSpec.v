Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_read_lr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition read_lr_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_33, st_0 == ((iasm_117_spec st));
      (Some (v_33, st_0)))
    else (
      if (v_0 =? (15))
      then (
        when v_3, st_0 == ((iasm_118_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (14))
        then (
          when v_5, st_0 == ((iasm_119_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (13))
          then (
            when v_7, st_0 == ((iasm_120_spec st));
            (Some (v_7, st_0)))
          else (
            if (v_0 =? (12))
            then (
              when v_9, st_0 == ((iasm_121_spec st));
              (Some (v_9, st_0)))
            else (
              if (v_0 =? (11))
              then (
                when v_11, st_0 == ((iasm_122_spec st));
                (Some (v_11, st_0)))
              else (
                if (v_0 =? (10))
                then (
                  when v_13, st_0 == ((iasm_123_spec st));
                  (Some (v_13, st_0)))
                else (
                  if (v_0 =? (9))
                  then (
                    when v_15, st_0 == ((iasm_124_spec st));
                    (Some (v_15, st_0)))
                  else (
                    if (v_0 =? (8))
                    then (
                      when v_17, st_0 == ((iasm_125_spec st));
                      (Some (v_17, st_0)))
                    else (
                      if (v_0 =? (7))
                      then (
                        when v_19, st_0 == ((iasm_126_spec st));
                        (Some (v_19, st_0)))
                      else (
                        if (v_0 =? (6))
                        then (
                          when v_21, st_0 == ((iasm_127_spec st));
                          (Some (v_21, st_0)))
                        else (
                          if (v_0 =? (5))
                          then (
                            when v_23, st_0 == ((iasm_128_spec st));
                            (Some (v_23, st_0)))
                          else (
                            if (v_0 =? (4))
                            then (
                              when v_25, st_0 == ((iasm_129_spec st));
                              (Some (v_25, st_0)))
                            else (
                              if (v_0 =? (3))
                              then (
                                when v_27, st_0 == ((iasm_130_spec st));
                                (Some (v_27, st_0)))
                              else (
                                if (v_0 =? (2))
                                then (
                                  when v_29, st_0 == ((iasm_131_spec st));
                                  (Some (v_29, st_0)))
                                else (
                                  if (v_0 =? (1))
                                  then (
                                    when v_31, st_0 == ((iasm_132_spec st));
                                    (Some (v_31, st_0)))
                                  else (Some (0, st))))))))))))))))).

End Layer9_read_lr_LowSpec.

#[global] Hint Unfold read_lr_spec_low: spec.
