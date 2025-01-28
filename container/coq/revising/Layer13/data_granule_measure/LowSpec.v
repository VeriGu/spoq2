Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_data_granule_measure_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_granule_measure_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "data_granule_measure" st));
    when st_1 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_7" 0) 0) 4 st_0));
    when st_2 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_7" 0) 8) v_2 st_1));
    when st_3 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_7" 0) 16) 0 st_2));
    when st_4 == ((free_stack "data_granule_measure" st_0 st_3));
    (Some st_4).

End Layer13_data_granule_measure_LowSpec.

#[global] Hint Unfold data_granule_measure_spec_low: spec.
