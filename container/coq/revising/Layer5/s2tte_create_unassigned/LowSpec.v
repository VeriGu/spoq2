Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_s2tte_create_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_unassigned_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((s2tte_create_ripas_spec v_0 st));
    (Some (v_2, st_0)).

End Layer5_s2tte_create_unassigned_LowSpec.

#[global] Hint Unfold s2tte_create_unassigned_spec_low: spec.
