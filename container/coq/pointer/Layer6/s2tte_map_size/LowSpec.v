Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_map_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_map_size_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((1 << ((((3 - (v_0)) * (9)) + (12)))), st)).

End Layer6_s2tte_map_size_LowSpec.

#[global] Hint Unfold s2tte_map_size_spec_low: spec.
