Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_s2_sl_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_sl_addr_to_idx_spec_low (v_addr: Z) (v_start_level: Z) (v_ipa_bits: Z) (st: RData) : (option (Z * RData)) :=
    let v_sub := (3 - (v_start_level)) in
    let v_mul := (v_sub * (9)) in
    let v_add := (v_mul + (12)) in
    let v_notmask := ((- 1) << (v_ipa_bits)) in
    let v_sub2 := (Z.lxor v_notmask (- 1)) in
    let v_and := (v_sub2 & (v_addr)) in
    let v_sh_prom := v_add in
    let v_shr := (v_and >> (v_sh_prom)) in
    let __return__ := true in
    let __retval__ := v_shr in
    (Some (__retval__, st)).

End Helpers_s2_sl_addr_to_idx_LowSpec.

#[global] Hint Unfold s2_sl_addr_to_idx_spec_low: spec.
