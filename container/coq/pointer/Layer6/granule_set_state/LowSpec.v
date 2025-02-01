Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_granule_set_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_set_state_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely ((((v_0.(poffset)) mod (16)) = (0)));
    when st_0 == ((store_RData_granules 4 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (4))) v_1 st));
    (Some st_0).

End Layer6_granule_set_state_LowSpec.

#[global] Hint Unfold granule_set_state_spec_low: spec.
