Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rec_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rec_destroy_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    let v_0_pa := (test_PA v_0) in
    when v_2, st_0 == ((find_lock_unused_granule_spec_abs v_0_pa 3 st));
    if ((v_2.(pbase)) =s ("null"))
    then (
      when v_9, st_3 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_9, st_3)))
    else (
      when v_13, st_2 == ((granule_map_spec v_2 3 st_0));
      let v_16 := (rec_to_rd_para v_13 st_2) in
      when st_4 == ((granule_memzero_mapped_spec v_13 st_2));
      when st_5 == ((granule_unlock_transition_spec v_2 1 st_4));
      when st_6 == ((__granule_put_spec v_16 st_5));
      (Some (0, st_6))).

End Layer13_smc_rec_destroy_LowSpec.

#[global] Hint Unfold smc_rec_destroy_spec_low: spec.
