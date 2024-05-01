Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RDState.Spec.
Require Import ValidateTable.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableAux_validate_data_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_data_create_spec_low (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((get_rd_state_locked_spec v_rd st));
    let v_cmp_not := (v_call =? (0)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp_not
        then (
          when v_call1, st == ((validate_data_create_unknown_spec v_map_addr v_rd st));
          let v_retval_0 := v_call1 in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := 2 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End TableAux_validate_data_create_LowSpec.

#[global] Hint Unfold validate_data_create_spec_low: spec.
