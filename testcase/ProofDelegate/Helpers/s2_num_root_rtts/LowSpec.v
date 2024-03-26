Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_s2_num_root_rtts_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_num_root_rtts_spec_low (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (Z * RData)) :=
    let v_sub := (3 - (v_sl)) in
    let v_mul := (v_sub * (9)) in
    let v_add1 := (v_mul + (21)) in
    let v_cmp_not := (v_add1 <? (v_ipa_bits)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp_not
        then (
          let v_sub4 := (v_ipa_bits - (v_add1)) in
          let v_shl := (1 << (v_sub4)) in
          let v_retval_0 := v_shl in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End Helpers_s2_num_root_rtts_LowSpec.

#[global] Hint Unfold s2_num_root_rtts_spec_low: spec.
