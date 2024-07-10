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
    when v_call, st_0 == ((is_feat_vmid16_present_spec st));
    rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
    when st_1 == ((atomic_bit_clear_release_64_spec (ptr_offset (mkPtr "vmids" 0) (8 * ((v_vmid >> (6))))) (v_vmid & (63)) st_0));
    (Some st_1).

End RealmCreate_vmid_free_LowSpec.

#[global] Hint Unfold vmid_free_spec_low: spec.
