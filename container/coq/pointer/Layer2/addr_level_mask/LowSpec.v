Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_addr_level_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_level_mask_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))))), st)).

End Layer2_addr_level_mask_LowSpec.

#[global] Hint Unfold addr_level_mask_spec_low: spec.
