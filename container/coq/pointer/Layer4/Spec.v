Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter s2_addr_to_idx_para : Z -> Z -> Z).

Section Layer4_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition cpuid_spec (st: RData) : (option (Z * RData)) :=
    (Some (CPU_ID, st)).

  Definition find_granule_spec_abs (v_0: abs_PA_t) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr "granules" (v_0.(meta_granule_offset))), st)).

  Definition find_granule_spec (v_0: Z) (st: Z) : (option (Ptr * RData)) :=
    None.

End Layer4_Spec.

#[global] Hint Unfold cpuid_spec: spec.
#[global] Hint Unfold find_granule_spec_abs: spec.
#[global] Hint Unfold find_granule_spec: spec.
