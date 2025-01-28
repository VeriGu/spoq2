Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_s2_addr_to_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_addr_to_idx_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (511)), st)).

End Layer4_s2_addr_to_idx_LowSpec.

#[global] Hint Unfold s2_addr_to_idx_spec_low: spec.
