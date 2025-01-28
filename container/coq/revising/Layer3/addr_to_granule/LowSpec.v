Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_addr_to_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition addr_to_granule_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))));
    when v_2, st_0 == ((addr_to_idx_spec v_0 st));
    when v_4, st_1 == ((granule_from_idx_spec (v_2 & (4294967295)) st_0));
    (Some (v_4, st_1)).

End Layer3_addr_to_granule_LowSpec.

#[global] Hint Unfold addr_to_granule_spec_low: spec.
