Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_bitmap_clear_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition bitmap_clear_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely ((((0 - ((v_1 >> (6)))) <= (0)) /\ (((v_1 >> (6)) < (1024)))));
    when v_8, st_0 == ((load_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) st));
    when st_1 == ((store_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) (v_8 & ((Z.lxor (v_1 & (63)) (- 1)))) st_0));
    (Some st_1).

End Layer11_bitmap_clear_LowSpec.

#[global] Hint Unfold bitmap_clear_spec_low: spec.
