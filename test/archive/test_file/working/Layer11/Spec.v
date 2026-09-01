Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_data_create_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (0, st)).

  Definition status_ptr_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((int_to_ptr (0 - (v_0))), st)).

End Layer11_Spec.

Opaque validate_data_create_spec.
#[global] Hint Unfold status_ptr_spec: spec.
