Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_addr_is_level_aligned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_is_level_aligned_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_3, st_0 == ((addr_level_mask_spec v_0 v_1 st));
    (Some (((v_3 - (v_0)) =? (0)), st_0)).

End Layer8_addr_is_level_aligned_LowSpec.

#[global] Hint Unfold addr_is_level_aligned_spec_low: spec.
