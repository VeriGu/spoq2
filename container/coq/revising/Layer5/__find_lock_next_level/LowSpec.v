Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5___find_lock_next_level_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_lock_next_level_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((s2_addr_to_idx_spec v_1 v_2 st));
    when v_5, st_1 == ((__find_next_level_idx_spec v_0 v_4 st_0));
    rely (((((v_5.(pbase)) = ("granules")) /\ ((((v_5.(poffset)) mod (16)) = (0)))) /\ (((v_5.(poffset)) >= (0)))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (Some (v_5, st_1))
    else (
      when st_2 == ((granule_lock_spec v_5 5 st_1));
      (Some (v_5, st_2))).

End Layer5___find_lock_next_level_LowSpec.

#[global] Hint Unfold __find_lock_next_level_spec_low: spec.
