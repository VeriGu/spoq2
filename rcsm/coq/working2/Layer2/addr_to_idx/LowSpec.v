Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_to_idx_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))));
    (Some (((v_0 + (18446744071562067968)) >> (12)), st)).

End Layer2_addr_to_idx_LowSpec.

#[global] Hint Unfold addr_to_idx_spec_low: spec.
