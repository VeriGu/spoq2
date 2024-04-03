Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_addr_level_mask_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_level_mask_spec_low (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    let v__neg := (v_level * (18446744069414584320)) in
    let v_sext := (v__neg + (12884901888)) in
    let v_0 := (v_sext >> (32)) in
    let v_1 := (v_0 * (9)) in
    let v_conv2 := (v_1 + (12)) in
    let v_sh_prom := (v_conv2 & (4294967295)) in
    let v_shl := ((- 1) << (v_sh_prom)) in
    let v_and := (v_addr & (281474976710655)) in
    let v_and5 := (v_and & (v_shl)) in
    let __return__ := true in
    let __retval__ := v_and5 in
    (Some (__retval__, st)).

End S2TTEDesc_addr_level_mask_LowSpec.

#[global] Hint Unfold addr_level_mask_spec_low: spec.
