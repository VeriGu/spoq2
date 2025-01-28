Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_s2tt_init_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint s2tt_init_valid_loop820_low (_N_: nat) (__return__: bool) (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_0, v_2, v_5, v__010, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_valid_loop820_low _N__0 __return__ v_0 v_2 v_5 v__010 v_indvars_iv st)) with
      | (Some (__return___0, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0)) =>
        if __return___0
        then (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0))
        else (
          when v_7, st_1 == ((s2tte_create_valid_spec v__11 v_3 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) v_7 st_1));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, v_3, v_6, (v__11 + (v_6)), (v_indvars_iv_0 + (1)), st_2))
          else (
            when st_3 == ((iasm_10_spec st_2));
            (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_3))))
      | None => None
      end
    end.

  Definition s2tt_init_valid_loop820_rank (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) : Z :=
    0.

  Definition s2tt_init_valid_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    when v_5, st_0 == ((s2tte_map_size_spec v_2 st));
    rely (((s2tt_init_valid_loop820_rank v_0 v_2 v_5 v_1 0) >= (0)));
    match ((s2tt_init_valid_loop820_low (z_to_nat (s2tt_init_valid_loop820_rank v_0 v_2 v_5 v_1 0)) false v_0 v_2 v_5 v_1 0 st_0)) with
    | (Some (__return__, v_7, v_3, v_6, v__11, v_indvars_iv_0, st_1)) => (Some st_1)
    | None => None
    end.

End Layer12_s2tt_init_valid_LowSpec.

#[global] Hint Unfold s2tt_init_valid_loop820_low: spec.
#[global] Hint Unfold s2tt_init_valid_loop820_rank: spec.
#[global] Hint Unfold s2tt_init_valid_spec_low: spec.
