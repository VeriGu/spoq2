Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmCreate_vmid_free_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition vmid_free_spec_low (v_vmid: Z) (st: RData) : (option RData) :=
    when v_call, st == ((is_feat_vmid16_present_spec st));
    let v_div := (v_vmid >> (6)) in
    let v_0 := (v_vmid & (63)) in
    let v_idxprom := v_div in
    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (1024)))));
    let v_arrayidx := (ptr_offset (mkPtr "vmids" 0) (((8 * (1024)) * (0)) + (((8 * (v_idxprom)) + (0))))) in
    when st == ((atomic_bit_clear_release_64_spec v_arrayidx v_0 st));
    let __return__ := true in
    (Some st).

End RealmCreate_vmid_free_LowSpec.

#[global] Hint Unfold vmid_free_spec_low: spec.
