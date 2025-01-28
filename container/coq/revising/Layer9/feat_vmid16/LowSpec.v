Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_feat_vmid16_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition feat_vmid16_spec_low (st: RData) : (option (bool * RData)) :=
    when v_1, st_0 == ((iasm_31_spec st));
    (Some (((v_1 & (240)) <>? (0)), st_0)).

End Layer9_feat_vmid16_LowSpec.

#[global] Hint Unfold feat_vmid16_spec_low: spec.
