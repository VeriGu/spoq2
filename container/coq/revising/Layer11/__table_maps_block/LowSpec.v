Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11___table_maps_block_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __table_maps_block_funptr_wrap954 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
    None.

  Fixpoint __table_maps_block_loop946_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_10: Z) (v_5: Z) (v__0: bool) (v__02223: Z) (v_2: Ptr) (st: RData) : (option (bool * Ptr * Z * Z * Z * bool * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_1, v_10, v_5, v__0, v__02223, v_2, st))
    | (S _N__0) =>
      match ((__table_maps_block_loop946_low _N__0 __break__ v_0 v_1 v_10 v_5 v__0 v__02223 v_2 st)) with
      | (Some (__break___0, v_7, v_3, v_11, v_6, v__1, v__2224, v_4, st_0)) =>
        if __break___0
        then (Some (true, v_7, v_3, v_11, v_6, v__1, v__2224, v_4, st_0))
        else (
          when v_18, st_1 == ((__tte_read_spec (ptr_offset v_7 (8 * (v__2224))) st_0));
          when v_19, st_2 == ((__table_maps_block_funptr_wrap954 v_4 v_18 v_3 st_1));
          if v_19
          then (
            when v_28, st_3 == ((s2tte_pa_spec v_18 v_3 st_2));
            if ((v_28 - (((v__2224 * (v_6)) + (v_11)))) =? (0))
            then (
              if ((v__2224 + (1)) <>? (512))
              then (Some (false, v_7, v_3, v_11, v_6, v__1, (v__2224 + (1)), v_4, st_3))
              else (Some (true, v_7, v_3, v_11, v_6, true, v__2224, v_4, st_3)))
            else (Some (true, v_7, v_3, v_11, v_6, false, v__2224, v_4, st_3)))
          else (Some (true, v_7, v_3, v_11, v_6, false, v__2224, v_4, st_2)))
      | None => None
      end
    end.

  Definition __table_maps_block_loop946_rank (v_0: Ptr) (v_1: Z) (v_10: Z) (v_5: Z) (v__02223: Z) (v_2: Ptr) : Z :=
    0.

  Definition __table_maps_block_funptr_wrap942 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
    None.

  Definition __table_maps_block_spec_low (v_0: Ptr) (v_1: Z) (v_2: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_5, st_0 == ((s2tte_map_size_spec v_1 st));
    when v_6, st_1 == ((__tte_read_spec v_0 st_0));
    when v_7, st_2 == ((__table_maps_block_funptr_wrap942 v_2 v_6 v_1 st_1));
    if v_7
    then (
      when v_10, st_3 == ((s2tte_pa_spec v_6 v_1 st_2));
      when v_12, st_4 == ((addr_is_level_aligned_spec v_10 (v_1 + ((- 1))) st_3));
      if v_12
      then (
        rely (((__table_maps_block_loop946_rank v_0 v_1 v_10 v_5 1 v_2) >= (0)));
        match ((__table_maps_block_loop946_low (z_to_nat (__table_maps_block_loop946_rank v_0 v_1 v_10 v_5 1 v_2)) false v_0 v_1 v_10 v_5 false 1 v_2 st_4)) with
        | (Some (__break__, v_14, v_3, v_13, v_8, v__2, v__2224, v_9, st_5)) => (Some (v__2, st_5))
        | None => None
        end)
      else (Some (false, st_4)))
    else (Some (false, st_2)).

End Layer11___table_maps_block_LowSpec.

#[global] Hint Unfold __table_maps_block_funptr_wrap954: spec.
#[global] Hint Unfold __table_maps_block_loop946_low: spec.
#[global] Hint Unfold __table_maps_block_loop946_rank: spec.
#[global] Hint Unfold __table_maps_block_funptr_wrap942: spec.
#[global] Hint Unfold __table_maps_block_spec_low: spec.
