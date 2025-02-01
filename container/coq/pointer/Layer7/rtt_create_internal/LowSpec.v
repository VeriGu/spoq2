Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_rtt_create_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_create_internal_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    None.

End Layer7_rtt_create_internal_LowSpec.

#[global] Hint Unfold rtt_create_internal_spec_low: spec.
