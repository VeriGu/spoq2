Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_esr_srt_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_srt_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (16)) & (31)), st)).

End Layer7_esr_srt_LowSpec.

#[global] Hint Unfold esr_srt_spec_low: spec.
