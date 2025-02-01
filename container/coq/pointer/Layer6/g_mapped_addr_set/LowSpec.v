Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_g_mapped_addr_set_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition g_mapped_addr_set_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) st));
    when st_1 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) ((v_4 & (4095)) |' (v_1)) st_0));
    (Some st_1).

End Layer6_g_mapped_addr_set_LowSpec.

#[global] Hint Unfold g_mapped_addr_set_spec_low: spec.
