Require Import CheckFeature.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmInfo_realm_vtcr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_vtcr_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((is_feat_vmid16_present_spec st));
    let v_cond := (
        if v_call
        then 3221894400
        else 3221370112) in
    when v_call1, st == ((realm_rtt_starting_level_spec v_rd st));
    let v_idxprom := v_call1 in
    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (4)))));
    let v_arrayidx := (ptr_offset (mkPtr "sl0_val" 0) (((8 * (4)) * (0)) + (((8 * (v_idxprom)) + (0))))) in
    when v_0, st == ((load_RData 8 v_arrayidx st));
    when v_call2, st == ((realm_ipa_bits_spec v_rd st));
    let v_sub := (0 - (v_call2)) in
    let v_and := (v_sub & (63)) in
    let v_or := (v_0 |' (v_cond)) in
    let v_or3 := (v_or |' (v_and)) in
    let __return__ := true in
    let __retval__ := v_or3 in
    (Some (__retval__, st)).

End RealmInfo_realm_vtcr_LowSpec.

#[global] Hint Unfold realm_vtcr_spec_low: spec.
