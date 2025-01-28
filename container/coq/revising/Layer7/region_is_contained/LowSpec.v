Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_region_is_contained_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition region_is_contained_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (bool * RData)) :=
    when v_5, st_0 == ((addr_is_contained_spec v_0 v_1 v_2 st));
    if v_5
    then (
      when v_8, st_1 == ((addr_is_contained_spec v_0 v_1 (v_3 + ((- 1))) st_0));
      (Some (v_8, st_1)))
    else (Some (false, st_0)).

End Layer7_region_is_contained_LowSpec.

#[global] Hint Unfold region_is_contained_spec_low: spec.
