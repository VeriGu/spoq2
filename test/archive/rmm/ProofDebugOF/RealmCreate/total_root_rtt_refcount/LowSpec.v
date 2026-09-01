Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import RealmCreate.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmCreate_total_root_rtt_refcount_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint total_root_rtt_refcount_loop348_low (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_refcount_0_lcssa: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
    | (S _N_) =>
      match ((total_root_rtt_refcount_loop348_low _N_ __break__ v_g_rtt v_indvars_iv v_refcount_08 v_refcount_0_lcssa v_wide_trip_count st)) with
      | (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st)) =>
        if __break__
        then (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
        else (
          let v_add_ptr := (ptr_offset v_g_rtt ((16 * (v_indvars_iv)) + (0))) in
          when st == ((granule_lock_spec v_add_ptr 6 st));
          let v_refcount1 := (ptr_offset v_g_rtt ((16 * (v_indvars_iv)) + ((8 + (0))))) in
          when v_0, st == ((load_RData 8 v_refcount1 st));
          let v_add := (v_0 + (v_refcount_08)) in
          when st == ((granule_unlock_spec v_add_ptr st));
          let v_indvars_iv_next := (v_indvars_iv + (1)) in
          let v_exitcond := (v_indvars_iv_next <>? (v_wide_trip_count)) in
          match (
            let __continue__ := false in
            if v_exitcond
            then (
              let v_indvars_iv := v_indvars_iv_next in
              let v_refcount_08 := v_add in
              let __continue__ := true in
              (Some (__break__, __continue__, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, st)))
            else (
              let v_refcount_0_lcssa := v_add in
              let __break__ := true in
              (Some (__break__, __continue__, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, st)))
          ) with
          | (Some (__break__, __continue__, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, st)) =>
            if __break__
            then (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
            else (
              if __continue__
              then (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
              else (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Definition total_root_rtt_refcount_spec_low (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option (Z * RData)) :=
    let v_cmp6 := (0 <? (v_num_rtts)) in
    when v_refcount_0_lcssa, st == (
        let v_refcount_0_lcssa := 0 in
        if v_cmp6
        then (
          let v_wide_trip_count := v_num_rtts in
          let v_indvars_iv := 0 in
          let v_refcount_08 := 0 in
          rely (((total_root_rtt_refcount_loop348_rank v_g_rtt v_indvars_iv v_refcount_08 v_wide_trip_count) >= (0)));
          match (
            (total_root_rtt_refcount_loop348_low
              (z_to_nat (total_root_rtt_refcount_loop348_rank v_g_rtt v_indvars_iv v_refcount_08 v_wide_trip_count))
              false
              v_g_rtt
              v_indvars_iv
              v_refcount_08
              0
              v_wide_trip_count
              st)
          ) with
          | (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st)) => (Some (v_refcount_0_lcssa, st))
          | None => None
          end)
        else (
          let v_refcount_0_lcssa := 0 in
          (Some (v_refcount_0_lcssa, st))));
    let __return__ := true in
    let __retval__ := v_refcount_0_lcssa in
    (Some (__retval__, st)).

End RealmCreate_total_root_rtt_refcount_LowSpec.

#[global] Hint Unfold total_root_rtt_refcount_loop348_low: spec.
#[global] Hint Unfold total_root_rtt_refcount_spec_low: spec.
