Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_gic_cpu_state_init_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition gic_cpu_state_init_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((memset_spec v_0 0 216 st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 72) 33025 st_0));
    (Some st_1).

End Layer12_gic_cpu_state_init_LowSpec.

#[global] Hint Unfold gic_cpu_state_init_spec_low: spec.
