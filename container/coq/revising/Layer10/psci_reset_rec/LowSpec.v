Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_psci_reset_rec_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_reset_rec_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((store_RData 8 (ptr_offset v_0 280) 965 st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 360) ((v_1 & (33554432)) |' (12912760)) st_0));
    (Some st_1).

End Layer10_psci_reset_rec_LowSpec.

#[global] Hint Unfold psci_reset_rec_spec_low: spec.
