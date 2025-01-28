Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_s1tte_is_writable_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s1tte_is_writable_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (128)) =? (0)), st)).

End Layer13_s1tte_is_writable_LowSpec.

#[global] Hint Unfold s1tte_is_writable_spec_low: spec.
