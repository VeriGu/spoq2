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
    if (((v_2 - (v_0)) >=? (0)) && ((((v_1 + ((- 1))) - (v_2)) >=? (0))))
    then (Some (((((v_3 + ((- 1))) - (v_0)) >=? (0)) && ((((v_1 + ((- 1))) - ((v_3 + ((- 1))))) >=? (0)))), st))
    else (Some (false, st)).

End Layer7_region_is_contained_LowSpec.

#[global] Hint Unfold region_is_contained_spec_low: spec.
