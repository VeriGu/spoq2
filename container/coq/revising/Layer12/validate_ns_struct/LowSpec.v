Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_validate_ns_struct_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_ns_struct_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_0 & (15)) =? (0))
    then (
      when v_10, st_0 == ((find_granule_spec (v_0 & (18446744073709547520)) st));
      rely ((((v_10.(pbase)) = ("granules")) \/ (((v_10.(pbase)) = ("null")))));
      when v_12, st_1 == ((find_granule_spec (((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) st_0));
      rely ((((v_12.(pbase)) = ("granules")) \/ (((v_12.(pbase)) = ("null")))));
      if (ptr_eqb v_10 v_12)
      then (Some (v_10, st_1))
      else (Some ((mkPtr "null" 0), st_1)))
    else (Some ((mkPtr "null" 0), st)).

End Layer12_validate_ns_struct_LowSpec.

#[global] Hint Unfold validate_ns_struct_spec_low: spec.
