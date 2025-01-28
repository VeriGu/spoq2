Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_virt_to_phys_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition virt_to_phys_spec_low (v_0: Z) (v_1: Z) (v_2: Ptr) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (((v_2.(pbase)) = ("stack_type_3")));
    if (v_1 =? (0))
    then (
      when st_0 == ((iasm_277_spec v_0 st));
      when st_2 == ((iasm_12_isb_spec st_0));
      when v_8, st_3 == ((iasm_get_par_el1_spec st_2));
      when st_4 == ((store_RData 8 v_2 v_8 st_3));
      if ((v_8 & (1)) =? (0))
      then (Some (((v_8 & (281474976706560)) |' ((v_0 & (4095)))), st_4))
      else (Some (0, st_4)))
    else (
      when st_0 == ((iasm_278_spec v_0 st));
      when st_2 == ((iasm_12_isb_spec st_0));
      when v_8, st_3 == ((iasm_get_par_el1_spec st_2));
      when st_4 == ((store_RData 8 v_2 v_8 st_3));
      if ((v_8 & (1)) =? (0))
      then (Some (((v_8 & (281474976706560)) |' ((v_0 & (4095)))), st_4))
      else (Some (0, st_4))).

End Layer8_virt_to_phys_LowSpec.

#[global] Hint Unfold virt_to_phys_spec_low: spec.
