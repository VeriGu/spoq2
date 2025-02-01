Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_granule_unlock_transition_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_unlock_transition_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_1 == (
        (granule_unlock_spec
          v_0
          (st.[share].[globals].[g_granules] :<
            ((((st.(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (16)) ==
              (((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_state_s_granule] :< v_1)))));
    (Some st_1).

End Layer7_granule_unlock_transition_LowSpec.

#[global] Hint Unfold granule_unlock_transition_spec_low: spec.
