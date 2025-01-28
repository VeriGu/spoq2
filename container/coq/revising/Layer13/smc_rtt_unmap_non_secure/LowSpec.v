Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_unmap_non_secure_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_unmap_non_secure_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((map_unmap_ns_spec v_0 v_1 v_2 0 1 st));
    (Some (v_4, st_0)).

End Layer13_smc_rtt_unmap_non_secure_LowSpec.

#[global] Hint Unfold smc_rtt_unmap_non_secure_spec_low: spec.
