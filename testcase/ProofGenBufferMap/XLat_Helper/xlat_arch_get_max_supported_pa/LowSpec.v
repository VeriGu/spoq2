Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section XLat_Helper_xlat_arch_get_max_supported_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_arch_get_max_supported_pa_spec_low (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((arch_feat_get_pa_width_spec st));
    let v_sh_prom := v_call in
    let v_notmask := ((- 1) << (v_sh_prom)) in
    let v_sub := (Z.lxor v_notmask (- 1)) in
    let __return__ := true in
    let __retval__ := v_sub in
    (Some (__retval__, st)).

End XLat_Helper_xlat_arch_get_max_supported_pa_LowSpec.

#[global] Hint Unfold xlat_arch_get_max_supported_pa_spec_low: spec.
