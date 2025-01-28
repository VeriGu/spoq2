Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_create_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_table_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_0 |' (3)), st)).

End Layer6_s2tte_create_table_LowSpec.

#[global] Hint Unfold s2tte_create_table_spec_low: spec.
