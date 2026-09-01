Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_my_cpuid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition my_cpuid_spec_low (st: RData) : (option (Z * RData)) :=
    when v_call, st_0 == ((read_tpidr_el2_spec st));
    (Some (v_call, st_0)).

End Helpers_my_cpuid_LowSpec.

#[global] Hint Unfold my_cpuid_spec_low: spec.
