Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_addr_is_contained_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_is_contained_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    (Some ((((v_2 - (v_0)) >=? (0)) && ((((v_1 + ((- 1))) - (v_2)) >=? (0)))), st)).

End Layer5_addr_is_contained_LowSpec.

#[global] Hint Unfold addr_is_contained_spec_low: spec.
