Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_update_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition update_ripas_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    when ret, pte == ((update_ripas_spec_abs (test_Ptr_PTE v_0) v_1 v_2 st));
    (Some (ret, st)).

End Layer8_update_ripas_LowSpec.

#[global] Hint Unfold update_ripas_spec_low: spec.
