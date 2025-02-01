Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer1_buffer_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_map_spec_low (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
    when v__0_in, st_0 == (
        if ((v_1 & (549755813888)) =? (0))
        then (Some ((v_1 + (18446744004990074880)), st))
        else (Some ((v_1 + (18446743457381744640)), st)));
    (Some ((int_to_ptr v__0_in), st_0)).

End Layer1_buffer_map_LowSpec.

#[global] Hint Unfold buffer_map_spec_low: spec.
