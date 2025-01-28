Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_find_lock_two_granules_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_two_granules_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (v_3: Z) (v_4: Z) (v_5: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "find_lock_two_granules" st));
    when st_1 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 0) 0 st_0));
    when st_2 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 8) v_0 st_1));
    when st_3 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 16) v_1 st_2));
    when st_4 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 24) (ptr_to_int (mkPtr "null" 0)) st_3));
    when st_6 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 40) 1 st_4));
    when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 48) v_3 st_6));
    when st_8 == ((store_RData 4 (ptr_offset (mkPtr "stack_type_6" 0) 56) v_4 st_7));
    when st_9 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_6" 0) 64) (ptr_to_int (mkPtr "null" 0)) st_8));
    when v_19, st_11 == ((find_lock_granules_spec (ptr_offset (mkPtr "stack_type_6" 0) 0) 2 st_9));
    when st_12 == ((free_stack "find_lock_two_granules" st_0 st_11));
    (Some (v_19, st_12)).

End Layer7_find_lock_two_granules_LowSpec.

#[global] Hint Unfold find_lock_two_granules_spec_low: spec.
