Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_find_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_granule_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
    when v_7, st_0 == ((addr_to_idx_spec v_0 st));
    if (v_7 >? (1572863))
    then (Some ((mkPtr "null" 0), st_0))
    else (
      when v_11, st_1 == ((granule_from_idx_spec v_7 st_0));
      (Some (v_11, st_1))).

End Layer4_find_granule_LowSpec.

#[global] Hint Unfold find_granule_spec_low: spec.
