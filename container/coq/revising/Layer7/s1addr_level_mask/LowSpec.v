Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_s1addr_level_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s1addr_level_mask_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (v_0)), st)).

End Layer7_s1addr_level_mask_LowSpec.

#[global] Hint Unfold s1addr_level_mask_spec_low: spec.
