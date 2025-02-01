Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2___tte_read_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __tte_read_spec_low (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    None.

End Layer2___tte_read_LowSpec.

#[global] Hint Unfold __tte_read_spec_low: spec.
