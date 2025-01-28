Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_get_realm_params_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_realm_params_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_4, st_0 == ((find_granule_spec (v_1 & (18446744073709547520)) st));
    rely ((((v_4.(pbase)) = ("granules")) \/ (((v_4.(pbase)) = ("null")))));
    if (ptr_eqb v_4 (mkPtr "null" 0))
    then (Some (false, st_0))
    else (
      when v_8, st_1 == ((ns_buffer_read_spec 0 v_1 64 v_0 st_0));
      when st_2 == ((ns_buffer_unmap_spec 0 st_1));
      (Some (v_8, st_2))).

End Layer12_get_realm_params_LowSpec.

#[global] Hint Unfold get_realm_params_spec_low: spec.
