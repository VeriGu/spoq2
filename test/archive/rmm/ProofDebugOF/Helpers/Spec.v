Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition my_cpuid_spec (st: RData) : (option (Z * RData)) :=
    (Some (CPU_ID, st)).

End Helpers_Spec.

#[global] Hint Unfold my_cpuid_spec: spec.
