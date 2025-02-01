Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_ns_buffer_read_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_buffer_read_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))))));
    if ((v_1 & (549755813888)) =? (0))
    then (
      rely (((((int_to_ptr (v_1 + (18446744004990074880))).(pbase)) = ("granule_data")) /\ ((((int_to_ptr (v_1 + (18446744004990074880))).(poffset)) >= (0)))));
      when v_6, st_2 == ((memcpy_ns_read_spec_state_oracle v_3 (int_to_ptr (v_1 + (18446744004990074880))) v_2 st));
      (Some (v_6, st_2)))
    else (
      rely (((((int_to_ptr (v_1 + (18446743457381744640))).(pbase)) = ("granule_data")) /\ ((((int_to_ptr (v_1 + (18446743457381744640))).(poffset)) >= (0)))));
      when v_6, st_2 == ((memcpy_ns_read_spec_state_oracle v_3 (int_to_ptr (v_1 + (18446743457381744640))) v_2 st));
      (Some (v_6, st_2))).

End Layer6_ns_buffer_read_LowSpec.

#[global] Hint Unfold ns_buffer_read_spec_low: spec.
