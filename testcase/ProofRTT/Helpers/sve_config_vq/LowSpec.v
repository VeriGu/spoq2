Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_sve_config_vq_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition sve_config_vq_spec_low (v_vq: Z) (st: RData) : (option RData) :=
    when v_call, st == ((read_zcr_el2_spec st));
    let v_and := (v_call & (15)) in
    let v_conv := v_vq in
    let v_cmp_not := (v_and =? (v_conv)) in
    when st == (
        if v_cmp_not
        then (Some st)
        else (
          let v_and2 := (v_call & ((- 16))) in
          let v_or := (v_and2 |' (v_conv)) in
          when st == ((write_zcr_el2_spec v_or st));
          when st == ((isb_spec st));
          (Some st)));
    let __return__ := true in
    (Some st).

End Helpers_sve_config_vq_LowSpec.

#[global] Hint Unfold sve_config_vq_spec_low: spec.
