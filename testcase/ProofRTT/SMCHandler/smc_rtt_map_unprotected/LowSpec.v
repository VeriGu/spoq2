Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rtt_map_unprotected_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_map_unprotected_spec_low (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((host_ns_s2tte_is_valid_spec v_s2tte v_ulevel st));
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_call
        then (
          when v_call1, st == ((map_unmap_ns_spec v_rd_addr v_map_addr v_ulevel v_s2tte 0 st));
          let v_retval_0 := v_call1 in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End SMCHandler_smc_rtt_map_unprotected_LowSpec.

#[global] Hint Unfold smc_rtt_map_unprotected_spec_low: spec.
