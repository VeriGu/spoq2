Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11___table_is_uniform_block_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __table_is_uniform_block_funptr_wrap907 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
    None.

  Fixpoint __table_is_uniform_block_loop904_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_14: bool) (v__068: Z) (v_1: Ptr) (st: RData) : (option (bool * Ptr * bool * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_14, v__068, v_1, st))
    | (S _N__0) =>
      match ((__table_is_uniform_block_loop904_low _N__0 __break__ v_0 v_14 v__068 v_1 st)) with
      | (Some (__break___0, v_3, v_15, v__69, v_2, st_0)) =>
        if __break___0
        then (Some (true, v_3, v_15, v__69, v_2, st_0))
        else (
          when v_8, st_1 == ((__tte_read_spec (ptr_offset v_3 (8 * (v__69))) st_0));
          when v_9, st_2 == ((__table_is_uniform_block_funptr_wrap907 v_2 v_8 st_1));
          if v_9
          then (
            if ((v__69 + (1)) <>? (512))
            then (Some (false, v_3, v_15, (v__69 + (1)), v_2, st_2))
            else (Some (true, v_3, ((v__69 + (1)) <? (512)), v__69, v_2, st_2)))
          else (Some (true, v_3, false, v__69, v_2, st_2)))
      | None => None
      end
    end.

  Definition __table_is_uniform_block_loop904_rank (v_0: Ptr) (v__068: Z) (v_1: Ptr) : Z :=
    0.

  Definition __table_is_uniform_block_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((__table_is_uniform_block_loop904_rank v_0 0 v_1) >= (0)));
    match ((__table_is_uniform_block_loop904_low (z_to_nat (__table_is_uniform_block_loop904_rank v_0 0 v_1)) false v_0 false 0 v_1 st)) with
    | (Some (__break__, v_3, v_14, v__69, v_2, st_0)) => (Some ((xorb v_14 true), st_0))
    | None => None
    end.

End Layer11___table_is_uniform_block_LowSpec.

#[global] Hint Unfold __table_is_uniform_block_funptr_wrap907: spec.
#[global] Hint Unfold __table_is_uniform_block_loop904_low: spec.
#[global] Hint Unfold __table_is_uniform_block_loop904_rank: spec.
#[global] Hint Unfold __table_is_uniform_block_spec_low: spec.
