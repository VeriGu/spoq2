Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section CheckFeature_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition is_feat_vmid16_present_spec (st: RData) : (option (bool * RData)) :=
    (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32)), st)).

End CheckFeature_Spec.

#[global] Hint Unfold is_feat_vmid16_present_spec: spec.
