Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_granule_from_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_from_idx_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((v_0 < (NR_GRANULES)) /\ ((v_0 >= (0)))));
    rely (((0 <= (v_0)) /\ ((v_0 < (1572864)))));
    let v_2 := (ptr_offset (mkPtr "granules" 0) (((16 * (1572864)) * (0)) + (((16 * (v_0)) + (0))))) in
    let __return__ := true in
    let __retval__ := v_2 in
    (Some (__retval__, st)).

End Layer2_granule_from_idx_LowSpec.

#[global] Hint Unfold granule_from_idx_spec_low: spec.
