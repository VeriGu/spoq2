Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_write_lr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition write_lr_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when st_0 == ((iasm_289_spec v_1 st));
      (Some st_0))
    else (
      if (v_0 =? (15))
      then (
        when st_0 == ((iasm_290_spec v_1 st));
        (Some st_0))
      else (
        if (v_0 =? (14))
        then (
          when st_0 == ((iasm_291_spec v_1 st));
          (Some st_0))
        else (
          if (v_0 =? (13))
          then (
            when st_0 == ((iasm_292_spec v_1 st));
            (Some st_0))
          else (
            if (v_0 =? (12))
            then (
              when st_0 == ((iasm_293_spec v_1 st));
              (Some st_0))
            else (
              if (v_0 =? (11))
              then (
                when st_0 == ((iasm_294_spec v_1 st));
                (Some st_0))
              else (
                if (v_0 =? (10))
                then (
                  when st_0 == ((iasm_295_spec v_1 st));
                  (Some st_0))
                else (
                  if (v_0 =? (9))
                  then (
                    when st_0 == ((iasm_296_spec v_1 st));
                    (Some st_0))
                  else (
                    if (v_0 =? (8))
                    then (
                      when st_0 == ((iasm_297_spec v_1 st));
                      (Some st_0))
                    else (
                      if (v_0 =? (7))
                      then (
                        when st_0 == ((iasm_298_spec v_1 st));
                        (Some st_0))
                      else (
                        if (v_0 =? (6))
                        then (
                          when st_0 == ((iasm_299_spec v_1 st));
                          (Some st_0))
                        else (
                          if (v_0 =? (5))
                          then (
                            when st_0 == ((iasm_300_spec v_1 st));
                            (Some st_0))
                          else (
                            if (v_0 =? (4))
                            then (
                              when st_0 == ((iasm_301_spec v_1 st));
                              (Some st_0))
                            else (
                              if (v_0 =? (3))
                              then (
                                when st_0 == ((iasm_302_spec v_1 st));
                                (Some st_0))
                              else (
                                if (v_0 =? (2))
                                then (
                                  when st_0 == ((iasm_303_spec v_1 st));
                                  (Some st_0))
                                else (
                                  if (v_0 =? (1))
                                  then (
                                    when st_0 == ((iasm_304_spec v_1 st));
                                    (Some st_0))
                                  else (Some st)))))))))))))))).

End Layer8_write_lr_LowSpec.

#[global] Hint Unfold write_lr_spec_low: spec.
