Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_validate_data_create_unknown_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_data_create_unknown_spec_low (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st == ((addr_in_par_spec v_rd v_map_addr st));
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_call
        then (
          when v_call1, st == ((validate_map_addr_spec v_map_addr 3 v_rd st));
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if v_call1
              then (
                let v_retval_0 := 0 in
                (Some (v_retval_0, st)))
              else (
                let v_retval_0 := 1 in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End ValidateTable_validate_data_create_unknown_LowSpec.

#[global] Hint Unfold validate_data_create_unknown_spec_low: spec.
