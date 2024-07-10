Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import InitRec.Spec.
Require Import MemRW.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section InitRec_free_rec_aux_granules_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint free_rec_aux_granules_loop176_low (_N_: nat) (__break__: bool) (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) (st: RData) : (option (bool * Z * Ptr * bool * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((free_rec_aux_granules_loop176_low _N__0 __break__ v_indvars_iv v_rec_aux v_scrub v_wide_trip_count st)) with
      | (Some (__break___0, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0))
        else (
          when v_0_tmp, st_1 == ((load_RData 8 (ptr_offset v_rec_aux_0 ((8 * (v_indvars_iv_0)) + (0))) st_0));
          when st_2 == ((granule_lock_spec (int_to_ptr v_0_tmp) 4 st_1));
          if v_scrub_0
          then (
            when st_3 == ((granule_memzero_spec (int_to_ptr v_0_tmp) (v_indvars_iv_0 + (6)) st_2));
            when st_5 == ((granule_unlock_transition_spec (int_to_ptr v_0_tmp) 1 st_3));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, (v_indvars_iv_0 + (1)), v_rec_aux_0, true, v_wide_trip_count_0, st_5))
            else (Some (true, v_indvars_iv_0, v_rec_aux_0, true, v_wide_trip_count_0, st_5)))
          else (
            when st_4 == ((granule_unlock_transition_spec (int_to_ptr v_0_tmp) 1 st_2));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, (v_indvars_iv_0 + (1)), v_rec_aux_0, false, v_wide_trip_count_0, st_4))
            else (Some (true, v_indvars_iv_0, v_rec_aux_0, false, v_wide_trip_count_0, st_4))))
      | None => None
      end
    end.

  Definition free_rec_aux_granules_spec_low (v_rec_aux: Ptr) (v_cnt: Z) (v_scrub: bool) (st: RData) : (option RData) :=
    if ((0 - (v_cnt)) <? (0))
    then (
      rely (((free_rec_aux_granules_loop176_rank 0 v_rec_aux v_scrub v_cnt) >= (0)));
      match ((free_rec_aux_granules_loop176_low (z_to_nat (free_rec_aux_granules_loop176_rank 0 v_rec_aux v_scrub v_cnt)) false 0 v_rec_aux v_scrub v_cnt st)) with
      | (Some (__break__, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0)) => (Some st_0)
      | None => None
      end)
    else (Some st).

End InitRec_free_rec_aux_granules_LowSpec.

#[global] Hint Unfold free_rec_aux_granules_loop176_low: spec.
#[global] Hint Unfold free_rec_aux_granules_spec_low: spec.
