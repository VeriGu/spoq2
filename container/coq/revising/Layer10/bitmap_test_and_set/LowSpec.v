Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_bitmap_test_and_set_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition bitmap_test_and_set_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((0 - ((v_1 >> (6)))) <= (0)) /\ (((v_1 >> (6)) < (1024)))));
    when v_7, st_0 == ((load_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) st));
    when st_1 == ((store_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) (v_7 |' ((v_1 & (63)))) st_0));
    (Some (false, st_1)).

End Layer10_bitmap_test_and_set_LowSpec.

#[global] Hint Unfold bitmap_test_and_set_spec_low: spec.
