Require Import CheckFeature.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmInfo_max_ipa_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition max_ipa_size_spec_low (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((arch_feat_get_pa_width_spec st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End RealmInfo_max_ipa_size_LowSpec.

#[global] Hint Unfold max_ipa_size_spec_low: spec.
