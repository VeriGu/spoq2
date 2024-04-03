Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_esr_sas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_sas_spec_low (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    let v_0 := v_esr in
    let v_1 := (v_0 >> (22)) in
    let v_conv := (v_1 & (3)) in
    let __return__ := true in
    let __retval__ := v_conv in
    (Some (__retval__, st)).

End Helpers_esr_sas_LowSpec.

#[global] Hint Unfold esr_sas_spec_low: spec.
