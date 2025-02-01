Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_esr_sas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_sas_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (22)) & (3)), st)).

End Layer6_esr_sas_LowSpec.

#[global] Hint Unfold esr_sas_spec_low: spec.
