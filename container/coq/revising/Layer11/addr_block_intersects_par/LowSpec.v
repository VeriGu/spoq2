Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_addr_block_intersects_par_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_block_intersects_par_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    if (v_1 =? (18446603885974913024))
    then (Some (false, st))
    else (
      when v_8, st_0 == ((load_RData 8 (ptr_offset v_0 48) st));
      when v_10, st_1 == ((load_RData 8 (ptr_offset v_0 56) st_0));
      when v_12, st_2 == ((s2tte_map_size_spec v_2 st_1));
      when v_13, st_3 == ((ranges_intersect_spec v_8 v_10 v_1 v_12 st_2));
      (Some (v_13, st_3))).

End Layer11_addr_block_intersects_par_LowSpec.

#[global] Hint Unfold addr_block_intersects_par_spec_low: spec.
