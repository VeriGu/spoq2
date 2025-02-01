Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_ranges_intersect_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ranges_intersect_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((((v_1 + (v_0)) - (v_2)) >? (0)) && ((((v_3 + (v_2)) - (v_0)) >? (0)))), st)).

End Layer7_ranges_intersect_LowSpec.

#[global] Hint Unfold ranges_intersect_spec_low: spec.
