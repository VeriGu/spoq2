Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_host_ns_s2tte_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition host_ns_s2tte_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((addr_level_mask_spec (- 1) v_1 st));
    (Some (((v_3 |' (1020)) & (v_0)), st_0)).

End Layer12_host_ns_s2tte_LowSpec.

#[global] Hint Unfold host_ns_s2tte_spec_low: spec.
