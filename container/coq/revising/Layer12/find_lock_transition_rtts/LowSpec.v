Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_find_lock_transition_rtts_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint find_lock_transition_rtts_loop209_low (_N_: nat) (__return__: bool) (__retval__: Z) (__break__: bool) (v_0: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Z * bool * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __retval__, __break__, v_0, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((find_lock_transition_rtts_loop209_low _N__0 __return__ __retval__ __break__ v_0 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__return___0, __retval___0, __break___0, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (__return___0, __retval___0, true, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          if __return___0
          then (Some (true, __retval___0, false, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_0))
          else (
            when v_7, st_1 == ((find_lock_granule_spec ((v_indvars_iv_0 * (4096)) + (v_1)) 1 st_0));
            rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
            rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
            if (ptr_eqb v_7 (mkPtr "null" 0))
            then (
              when v_10, st_2 == ((find_granule_spec v_1 st_1));
              rely ((((v_10.(pbase)) = ("granules")) \/ (((v_10.(pbase)) = ("null")))));
              when st_3 == ((free_sl_rtts_spec v_10 v_indvars_iv_0 false st_2));
              when v_11, st_4 == ((make_return_code_spec 2 1 st_3));
              (Some (true, v_11, false, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_4)))
            else (
              when v_13, st_3 == ((granule_map_spec v_7 1 st_1));
              when st_4 == ((s2tt_init_unassigned_spec v_13 1 st_3));
              when st_5 == ((granule_unlock_transition_spec v_7 5 st_4));
              if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
              then (Some (false, __retval___0, false, v_1, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_5))
              else (Some (false, __retval___0, true, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_5)))))
      | None => None
      end
    end.

  Definition find_lock_transition_rtts_loop209_rank (v_0: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Definition find_lock_transition_rtts_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((0 - (v_1)) <? (0))
    then (
      rely (((find_lock_transition_rtts_loop209_rank v_0 0 v_1) >= (0)));
      match (
        match ((find_lock_transition_rtts_loop209_low (z_to_nat (find_lock_transition_rtts_loop209_rank v_0 0 v_1)) false 0 false v_0 0 v_1 st)) with
        | (Some (__return___0, __retval___0, __break__, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some (__return___0, __retval___0, st_0))
        | None => None
        end
      ) with
      | (Some (__return__, __retval__, st_0)) =>
        if __return__
        then (Some (__retval__, st_0))
        else (
          when v_16, st_1 == ((make_return_code_spec 0 0 st_0));
          (Some (v_16, st_1)))
      | None => None
      end)
    else (
      when v_16, st_1 == ((make_return_code_spec 0 0 st));
      (Some (v_16, st_1))).

End Layer12_find_lock_transition_rtts_LowSpec.

#[global] Hint Unfold find_lock_transition_rtts_loop209_low: spec.
#[global] Hint Unfold find_lock_transition_rtts_loop209_rank: spec.
#[global] Hint Unfold find_lock_transition_rtts_spec_low: spec.
