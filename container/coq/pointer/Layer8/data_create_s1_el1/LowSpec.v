Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_data_create_s1_el1_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_create_s1_el1_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    None.

End Layer8_data_create_s1_el1_LowSpec.

#[global] Hint Unfold data_create_s1_el1_spec_low: spec.
