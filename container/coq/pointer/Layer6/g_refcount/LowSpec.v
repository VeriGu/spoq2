Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_g_refcount_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition g_refcount_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) st));
    (Some ((v_3 & (4095)), st_0)).

End Layer6_g_refcount_LowSpec.

#[global] Hint Unfold g_refcount_spec_low: spec.
