Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_s2_inconsistent_sl_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_inconsistent_sl_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((((40 + (((- 9) * (v_1)))) - (v_0)) >? (0)) || ((((52 + (((- 9) * (v_1)))) - (v_0)) <? (0)))), st)).

End Layer10_s2_inconsistent_sl_LowSpec.

#[global] Hint Unfold s2_inconsistent_sl_spec_low: spec.
