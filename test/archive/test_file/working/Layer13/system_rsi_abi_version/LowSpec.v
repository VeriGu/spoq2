Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_system_rsi_abi_version_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition system_rsi_abi_version_spec_low (st: RData) : (option (Z * RData)) :=
    (Some (327680, st)).

End Layer13_system_rsi_abi_version_LowSpec.

#[global] Hint Unfold system_rsi_abi_version_spec_low: spec.
