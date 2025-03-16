Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_find_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_granule_spec_low (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_addr & (4095)) =? (0))
    then (
      when v_call, st_0 == ((plat_granule_addr_to_idx_spec v_addr st));
      if (v_call >? (1048575))
      then (Some ((mkPtr "null" 0), st_0))
      else (
        when v_call4, st_1 == ((granule_from_idx_spec v_call st_0));
        (Some (v_call4, st_1))))
    else (Some ((mkPtr "null" 0), st)).

End FindGranule_find_granule_LowSpec.

#[global] Hint Unfold find_granule_spec_low: spec.
