Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_addr_to_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_to_granule_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    None.

End Layer3_addr_to_granule_LowSpec.

#[global] Hint Unfold addr_to_granule_spec_low: spec.
