Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_set_rd_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition set_rd_state_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((v_0.(pbase)) = ("granule_data")));
    when st_0 == ((store_RData 64 (mkPtr (v_0.(pbase)) (v_0.(poffset))) v_1 st));
    (Some st_0).

End Layer5_set_rd_state_LowSpec.

#[global] Hint Unfold set_rd_state_spec_low: spec.
