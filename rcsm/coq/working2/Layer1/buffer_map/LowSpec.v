Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_buffer_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_map_spec_low (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) /\ (((v_1 & (549755813888)) = (0)))));
    (Some ((int_to_ptr (v_1 + (18446744004990074880))), st)).

End Layer1_buffer_map_LowSpec.

#[global] Hint Unfold buffer_map_spec_low: spec.
