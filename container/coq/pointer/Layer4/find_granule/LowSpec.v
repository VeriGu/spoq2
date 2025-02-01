Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_find_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_granule_spec_low (v_0: Z) (st: Z) : (option (Ptr * RData)) :=
    None.

End Layer4_find_granule_LowSpec.

#[global] Hint Unfold find_granule_spec_low: spec.
