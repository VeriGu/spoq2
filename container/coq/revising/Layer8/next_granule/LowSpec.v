Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_next_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition next_granule_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 + (4096)) & (18446744073709547520)), st)).

End Layer8_next_granule_LowSpec.

#[global] Hint Unfold next_granule_spec_low: spec.
