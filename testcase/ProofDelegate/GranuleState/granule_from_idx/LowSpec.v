Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleState_granule_from_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_from_idx_spec_low (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((0 <= (v_idx)) /\ ((v_idx < (1048576)))));
    let v_arrayidx := (ptr_offset (mkPtr "granules" 0) (((16 * (1048576)) * (0)) + (((16 * (v_idx)) + (0))))) in
    let __return__ := true in
    let __retval__ := v_arrayidx in
    (Some (__retval__, st)).

End GranuleState_granule_from_idx_LowSpec.

#[global] Hint Unfold granule_from_idx_spec_low: spec.
