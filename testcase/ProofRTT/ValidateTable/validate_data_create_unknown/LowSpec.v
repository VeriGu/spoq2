Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import ValidateAddr.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_validate_data_create_unknown_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_data_create_unknown_spec_low (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st_0 == ((addr_in_par_spec v_rd v_map_addr st));
    if v_call
    then (
      when v_call1, st_1 == ((validate_map_addr_spec v_map_addr 3 v_rd st_0));
      if v_call1
      then (Some (0, st_1))
      else (Some (1, st_1)))
    else (Some (1, st_0)).

End ValidateTable_validate_data_create_unknown_LowSpec.

#[global] Hint Unfold validate_data_create_unknown_spec_low: spec.
