Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_copy_gic_state_to_ns_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint copy_gic_state_to_ns_loop59_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_1, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((copy_gic_state_to_ns_loop59_low _N__0 __break__ v_0 v_1 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (16)))));
          when v_7, st_1 == ((load_RData 8 (ptr_offset v_3 (80 + ((8 * (v_indvars_iv_0))))) st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_2 (168 + ((8 * (v_indvars_iv_0))))) v_7 st_1));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_3, v_2, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_2))
          else (Some (true, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_2)))
      | None => None
      end
    end.

  Definition copy_gic_state_to_ns_loop59_rank (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Definition copy_gic_state_to_ns_0_low (st_0: RData) (v_0: Ptr) (v_1: Ptr) (v_3: Z) : (option RData) :=
    rely ((((0 - (v_3)) <? (0)) = (true)));
    rely (((copy_gic_state_to_ns_loop59_rank v_0 v_1 0 v_3) >= (0)));
    match ((copy_gic_state_to_ns_loop59_low (z_to_nat (copy_gic_state_to_ns_loop59_rank v_0 v_1 0 v_3)) false v_0 v_1 0 v_3 st_0)) with
    | (Some (__break__, v_5, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_1)) =>
      when v_11, st_3 == ((load_RData 8 (ptr_offset v_0 208) st_1));
      when st_4 == ((store_RData 8 (ptr_offset v_1 128) v_11 st_3));
      when v_14, st_5 == ((load_RData 8 (ptr_offset v_0 64) st_4));
      when st_6 == ((store_RData 8 (ptr_offset v_1 120) v_14 st_5));
      when v_17, st_7 == ((load_RData 8 (ptr_offset v_0 72) st_6));
      when st_8 == ((store_RData 8 (ptr_offset v_1 296) (v_17 & (4160766206)) st_7));
      (Some st_8)
    | None => None
    end.



  Definition copy_gic_state_to_ns_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((load_RData 4 (mkPtr "nr_lrs" 0) st));
    if ((0 - (v_3)) <? (0))
    then (copy_gic_state_to_ns_0_low st_0 v_0 v_1 v_3)
    else (
      when v_11, st_2 == ((load_RData 8 (ptr_offset v_0 208) st_0));
      when st_3 == ((store_RData 8 (ptr_offset v_1 128) v_11 st_2));
      when v_14, st_4 == ((load_RData 8 (ptr_offset v_0 64) st_3));
      when st_5 == ((store_RData 8 (ptr_offset v_1 120) v_14 st_4));
      when v_17, st_6 == ((load_RData 8 (ptr_offset v_0 72) st_5));
      when st_7 == ((store_RData 8 (ptr_offset v_1 296) (v_17 & (4160766206)) st_6));
      (Some st_7)).

End Layer12_copy_gic_state_to_ns_LowSpec.

#[global] Hint Unfold copy_gic_state_to_ns_loop59_low: spec.
#[global] Hint Unfold copy_gic_state_to_ns_loop59_rank: spec.
#[global] Hint Unfold copy_gic_state_to_ns_spec_low: spec.
#[global] Hint Unfold copy_gic_state_to_ns_0_low: spec.
