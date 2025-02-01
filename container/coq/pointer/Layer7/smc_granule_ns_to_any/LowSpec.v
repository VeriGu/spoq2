Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_smc_granule_ns_to_any_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_ns_to_any_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    None.

End Layer7_smc_granule_ns_to_any_LowSpec.

#[global] Hint Unfold smc_granule_ns_to_any_spec_low: spec.
