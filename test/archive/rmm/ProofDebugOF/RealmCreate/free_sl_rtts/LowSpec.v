Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import MemRW.Spec.
Require Import RealmCreate.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmCreate_free_sl_rtts_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint free_sl_rtts_loop193_low (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
    | (S _N_) =>
      match ((free_sl_rtts_loop193_low _N_ __break__ v_g_rtt v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st)) =>
        if __break__
        then (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
        else (
          let v_add_ptr := (ptr_offset v_g_rtt ((16 * (v_indvars_iv)) + (0))) in
          when st == ((granule_lock_spec v_add_ptr 6 st));
          when st == ((granule_memzero_spec v_add_ptr 22 st));
          when st == ((granule_unlock_transition_spec v_add_ptr 1 st));
          let v_indvars_iv_next := (v_indvars_iv + (1)) in
          let v_exitcond := (v_indvars_iv_next <>? (v_wide_trip_count)) in
          match (
            let __continue__ := false in
            if v_exitcond
            then (
              let v_indvars_iv := v_indvars_iv_next in
              let __continue__ := true in
              (Some (__break__, __continue__, v_indvars_iv, st)))
            else (
              let __break__ := true in
              (Some (__break__, __continue__, v_indvars_iv, st)))
          ) with
          | (Some (__break__, __continue__, v_indvars_iv, st)) =>
            if __break__
            then (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
            else (
              if __continue__
              then (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
              else (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Definition free_sl_rtts_spec_low (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option RData) :=
    let v_cmp5 := (0 <? (v_num_rtts)) in
    when st == (
        if v_cmp5
        then (
          let v_wide_trip_count := v_num_rtts in
          let v_indvars_iv := 0 in
          rely (((free_sl_rtts_loop193_rank v_g_rtt v_indvars_iv v_wide_trip_count) >= (0)));
          match ((free_sl_rtts_loop193_low (z_to_nat (free_sl_rtts_loop193_rank v_g_rtt v_indvars_iv v_wide_trip_count)) false v_g_rtt v_indvars_iv v_wide_trip_count st)) with
          | (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st)) => (Some st)
          | None => None
          end)
        else (Some st));
    let __return__ := true in
    (Some st).

End RealmCreate_free_sl_rtts_LowSpec.

#[global] Hint Unfold free_sl_rtts_loop193_low: spec.
#[global] Hint Unfold free_sl_rtts_spec_low: spec.
