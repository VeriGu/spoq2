Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_free_sl_rtts_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint free_sl_rtts_loop194_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_2: bool) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * bool * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_2, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((free_sl_rtts_loop194_low _N__0 __break__ v_0 v_2 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_1, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          when st_1 == ((granule_lock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 5 st_0));
          if v_3
          then (
            when st_2 == ((granule_memzero_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 6 st_1));
            when st_4 == ((granule_unlock_transition_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 1 st_2));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, v_1, true, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_4))
            else (Some (true, v_1, true, v_indvars_iv_0, v_wide_trip_count_0, st_4)))
          else (
            when st_3 == ((granule_unlock_transition_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 1 st_1));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, v_1, false, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_3))
            else (Some (true, v_1, false, v_indvars_iv_0, v_wide_trip_count_0, st_3))))
      | None => None
      end
    end.

  Definition free_sl_rtts_loop194_rank (v_0: Ptr) (v_2: bool) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Definition free_sl_rtts_spec_low (v_0: Ptr) (v_1: Z) (v_2: bool) (st: RData) : (option RData) :=
    if ((0 - (v_1)) <? (0))
    then (
      rely (((free_sl_rtts_loop194_rank v_0 v_2 0 v_1) >= (0)));
      match ((free_sl_rtts_loop194_low (z_to_nat (free_sl_rtts_loop194_rank v_0 v_2 0 v_1)) false v_0 v_2 0 v_1 st)) with
      | (Some (__break__, v_5, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
      | None => None
      end)
    else (Some st).

End Layer11_free_sl_rtts_LowSpec.

#[global] Hint Unfold free_sl_rtts_loop194_low: spec.
#[global] Hint Unfold free_sl_rtts_loop194_rank: spec.
#[global] Hint Unfold free_sl_rtts_spec_low: spec.
