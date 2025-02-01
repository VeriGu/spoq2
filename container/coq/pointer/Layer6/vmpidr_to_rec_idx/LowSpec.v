Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_vmpidr_to_rec_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition vmpidr_to_rec_idx_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((((v_0 >> (4)) & (4080)) |' ((v_0 & (15)))) |' (((v_0 >> (4)) & (1044480)))) |' (((v_0 >> (12)) & (267386880)))), st)).

End Layer6_vmpidr_to_rec_idx_LowSpec.

#[global] Hint Unfold vmpidr_to_rec_idx_spec_low: spec.
