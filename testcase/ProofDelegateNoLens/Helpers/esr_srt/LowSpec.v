Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_esr_srt_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_srt_spec_low (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    let v_0 := v_esr in
    let v_1 := (v_0 >> (16)) in
    let v_conv := (v_1 & (31)) in
    let __return__ := true in
    let __retval__ := v_conv in
    (Some (__retval__, st)).

End Helpers_esr_srt_LowSpec.

#[global] Hint Unfold esr_srt_spec_low: spec.
