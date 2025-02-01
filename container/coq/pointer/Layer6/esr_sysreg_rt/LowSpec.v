Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_esr_sysreg_rt_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_sysreg_rt_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (5)) & (31)), st)).

End Layer6_esr_sysreg_rt_LowSpec.

#[global] Hint Unfold esr_sysreg_rt_spec_low: spec.
