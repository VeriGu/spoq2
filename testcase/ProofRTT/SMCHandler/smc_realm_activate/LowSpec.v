Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_realm_activate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_activate_spec_low (v_rd_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((find_lock_granule_spec v_rd_addr 2 st));
    let v_cmp := (ptr_eqb v_call (mkPtr "null" 0)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp
        then (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st)))
        else (
          when v_call1, st == ((granule_map_spec v_call 2 st));
          let v_0 := v_call1 in
          when v_call2, st == ((get_rd_state_locked_spec v_0 st));
          let v_cmp3 := (v_call2 =? (0)) in
          when v_ret_0, st == (
              let v_ret_0 := 0 in
              if v_cmp3
              then (
                when st == ((set_rd_state_spec v_0 1 st));
                let v_ret_0 := 0 in
                (Some (v_ret_0, st)))
              else (
                let v_ret_0 := 2 in
                (Some (v_ret_0, st))));
          when st == ((buffer_unmap_spec v_call1 st));
          when st == ((granule_unlock_spec v_call st));
          let v_retval_0 := v_ret_0 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End SMCHandler_smc_realm_activate_LowSpec.

#[global] Hint Unfold smc_realm_activate_spec_low: spec.
