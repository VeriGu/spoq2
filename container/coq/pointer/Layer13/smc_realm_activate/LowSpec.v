Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_realm_activate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_activate_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    let v_0_pa := (test_PA v_0) in
    when v_2, st_0 == ((find_lock_granule_spec_abs v_0_pa 2 st));
    rely (((((v_2.(poffset)) mod (16)) = (0)) /\ (((v_2.(poffset)) >= (0)))));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_4, st_1)))
    else (
      when v_7, st_1 == ((granule_map_spec v_2 2 st_0));
      when v_9, st_2 == ((get_rd_state_locked_spec v_7 st_1));
      if (v_9 =? (0))
      then (
        when st_3 == ((measurement_finish_spec (ptr_offset v_7 72) (ptr_offset v_7 184) st_2));
        when st_4 == ((set_rd_state_spec v_7 1 st_3));
        when st_6 == ((granule_unlock_spec v_2 st_4));
        (Some (0, st_6)))
      else (
        when v_17, st_3 == ((pack_return_code_spec 5 0 st_2));
        when st_5 == ((granule_unlock_spec v_2 st_3));
        (Some (v_17, st_5)))).

End Layer13_smc_realm_activate_LowSpec.

#[global] Hint Unfold smc_realm_activate_spec_low: spec.
