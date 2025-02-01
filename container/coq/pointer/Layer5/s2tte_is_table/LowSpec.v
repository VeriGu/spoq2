Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_s2tte_is_table_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_table_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_1 <? (3)) && (((v_0 & (3)) =? (3)))), st)).

End Layer5_s2tte_is_table_LowSpec.

#[global] Hint Unfold s2tte_is_table_spec_low: spec.
