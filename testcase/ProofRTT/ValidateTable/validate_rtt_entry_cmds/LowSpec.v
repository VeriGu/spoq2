Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section ValidateTable_validate_rtt_entry_cmds_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition validate_rtt_entry_cmds_spec_low (v_map_addr: Z) (v_level: Z) (v_rd: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_rd.(poffset)) = (0)));
    rely (((v_rd.(pbase)) = ("slot_rd")));
    when v_call, st == ((realm_rtt_starting_level_spec v_rd st));
    let v_conv := v_call in
    let v_cmp := (v_conv >? (v_level)) in
    let v_cmp2 := (v_level >? (3)) in
    let v_or_cond := (v_cmp2 || (v_cmp)) in
    when v_retval_0, st == (
        let v_retval_0 := false in
        if v_or_cond
        then (
          let v_retval_0 := false in
          (Some (v_retval_0, st)))
        else (
          when v_call4, st == ((validate_map_addr_spec v_map_addr v_level v_rd st));
          let v_retval_0 := v_call4 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End ValidateTable_validate_rtt_entry_cmds_LowSpec.

#[global] Hint Unfold validate_rtt_entry_cmds_spec_low: spec.
