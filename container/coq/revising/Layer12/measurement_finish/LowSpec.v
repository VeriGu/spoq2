Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_measurement_finish_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition measurement_finish_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    (Some st).

End Layer12_measurement_finish_LowSpec.

#[global] Hint Unfold measurement_finish_spec_low: spec.
