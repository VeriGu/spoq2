Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_process_disposed_info_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition process_disposed_info_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 1 (ptr_offset v_0 896) st));
    if ((v_4 & (1)) =? (0))
    then (Some st_0)
    else (
      when st_1 == ((store_RData 8 (ptr_offset v_0 24) 0 st_0));
      when v_9, st_2 == ((load_RData 8 (ptr_offset v_1 72) st_1));
      if (v_9 =? (0))
      then (
        when st_3 == ((store_RData 8 (ptr_offset v_0 32) 0 st_2));
        when st_5 == ((store_RData 1 (ptr_offset v_0 896) 0 st_3));
        (Some st_5))
      else (
        when st_3 == ((store_RData 8 (ptr_offset v_0 32) 1 st_2));
        when st_5 == ((store_RData 1 (ptr_offset v_0 896) 0 st_3));
        (Some st_5))).

End Layer12_process_disposed_info_LowSpec.

#[global] Hint Unfold process_disposed_info_spec_low: spec.
