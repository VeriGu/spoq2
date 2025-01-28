Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_s2_num_root_rtts_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_num_root_rtts_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (((48 + (((- 9) * (v_1)))) - (v_0)) <? (0))
    then (Some ((1 << ((v_0 - ((48 + (((- 9) * (v_1)))))))), st))
    else (Some (1, st)).

End Layer11_s2_num_root_rtts_LowSpec.

#[global] Hint Unfold s2_num_root_rtts_spec_low: spec.
