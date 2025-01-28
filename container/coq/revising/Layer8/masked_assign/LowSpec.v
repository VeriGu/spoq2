Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_masked_assign_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition masked_assign_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData 8 v_0 st));
    when st_1 == ((store_RData 8 v_0 ((v_4 & ((Z.lxor v_2 (- 1)))) |' ((v_2 & (v_1)))) st_0));
    (Some st_1).

End Layer8_masked_assign_LowSpec.

#[global] Hint Unfold masked_assign_spec_low: spec.
