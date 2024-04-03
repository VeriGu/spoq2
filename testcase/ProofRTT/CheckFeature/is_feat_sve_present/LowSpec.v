Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section CheckFeature_is_feat_sve_present_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition is_feat_sve_present_spec_low (st: RData) : (option (bool * RData)) :=
    when v_call, st == ((read_id_aa64pfr0_el1_spec st));
    let v_0 := (v_call & (64424509440)) in
    let v_cmp := (v_0 <>? (0)) in
    let __return__ := true in
    let __retval__ := v_cmp in
    (Some (__retval__, st)).

End CheckFeature_is_feat_sve_present_LowSpec.

#[global] Hint Unfold is_feat_sve_present_spec_low: spec.
