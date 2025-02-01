Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_get_realm_identity_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_realm_identity_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("stack_s_q_useful_buf")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_1.(pbase)) = ("stack_s_q_useful_buf")) /\ (((v_1.(poffset)) >= (0)))))));
    when st_0 == ((store_RData 8 v_1 32 st));
    rely (((0 <= (0)) /\ ((0 < (32)))));
    when st_1 == ((store_RData 8 v_0 (ptr_to_int (mkPtr "get_realm_identity_identity" 0)) st_0));
    (Some st_1).

End Layer6_get_realm_identity_LowSpec.

#[global] Hint Unfold get_realm_identity_spec_low: spec.
