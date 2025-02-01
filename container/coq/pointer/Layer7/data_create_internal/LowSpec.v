Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_data_create_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_create_internal_spec_low (v_0: Z) (v_1: Ptr) (v_2: Z) (v_3: Ptr) (v_4: Ptr) (v_5: Z) (st: RData) : (option (Z * RData)) :=
    None.

End Layer7_data_create_internal_LowSpec.

#[global] Hint Unfold data_create_internal_spec_low: spec.
