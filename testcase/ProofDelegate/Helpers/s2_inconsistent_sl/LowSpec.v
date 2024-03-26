Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_s2_inconsistent_sl_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_inconsistent_sl_spec_low (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (bool * RData)) :=
    let v_sub := (3 - (v_sl)) in
    let v_mul := (v_sub * (9)) in
    let v_add1 := (v_mul + (13)) in
    let v_add5 := (v_mul + (25)) in
    let v_cmp := (v_add1 >? (v_ipa_bits)) in
    let v_cmp8 := (v_add5 <? (v_ipa_bits)) in
    let v_0 := (v_cmp || (v_cmp8)) in
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End Helpers_s2_inconsistent_sl_LowSpec.

#[global] Hint Unfold s2_inconsistent_sl_spec_low: spec.
