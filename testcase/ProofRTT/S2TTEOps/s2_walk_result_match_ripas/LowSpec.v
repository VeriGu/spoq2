Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEOps_s2_walk_result_match_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2_walk_result_match_ripas_spec_low (v_res: Ptr) (v_ripas: Z) (st: RData) : (option (bool * RData)) :=
    rely (
      ((((v_res.(pbase)) = ("handle_rsi_realm_config_stack")) \/ (((v_res.(pbase)) = ("do_host_call_stack")))) \/
        (((v_res.(pbase)) = ("attest_token_continue_write_state_stack")))));
    let v_destroyed := (ptr_offset v_res ((32 * (0)) + ((20 + (0))))) in
    when v_0, st == ((load_RData 1 v_destroyed st));
    let v_1 := (v_0 & (1)) in
    let v_tobool_not := (v_1 =? (0)) in
    when v_3, st == (
        let v_3 := false in
        if v_tobool_not
        then (
          let v_ripas1 := (ptr_offset v_res ((32 * (0)) + ((16 + (0))))) in
          when v_2, st == ((load_RData 4 v_ripas1 st));
          let v_cmp := (v_2 =? (0)) in
          let v_3 := v_cmp in
          (Some (v_3, st)))
        else (
          let v_3 := false in
          (Some (v_3, st))));
    let __return__ := true in
    let __retval__ := v_3 in
    (Some (__retval__, st)).

End S2TTEOps_s2_walk_result_match_ripas_LowSpec.

#[global] Hint Unfold s2_walk_result_match_ripas_spec_low: spec.
