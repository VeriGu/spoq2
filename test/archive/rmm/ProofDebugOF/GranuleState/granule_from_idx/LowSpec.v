Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_granule_from_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_from_idx_spec_low (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (v_idx)) <= (0)) /\ ((v_idx < (1048576)))));
    (Some ((ptr_offset (mkPtr "granules" 0) (16 * (v_idx))), st)).

End GranuleState_granule_from_idx_LowSpec.

#[global] Hint Unfold granule_from_idx_spec_low: spec.
