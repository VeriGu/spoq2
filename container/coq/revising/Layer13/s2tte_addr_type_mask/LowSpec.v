Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_s2tte_addr_type_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_addr_type_mask_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (3)) =? (0))
    then (Some (0, st))
    else (
      when v_7, st_0 == ((s2tte_pa_spec v_0 v_1 st));
      (Some ((v_7 |' ((v_0 & (3)))), st_0))).

End Layer13_s2tte_addr_type_mask_LowSpec.

#[global] Hint Unfold s2tte_addr_type_mask_spec_low: spec.
