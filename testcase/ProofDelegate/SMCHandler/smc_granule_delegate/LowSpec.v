Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_granule_delegate_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_granule_delegate_spec_low (v_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((find_lock_granule_spec v_addr 0 st));
    let v_cmp := (ptr_eqb v_call (mkPtr "null" 0)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_cmp
        then (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st)))
        else (
          when v_call1, st == ((rmm_el3_ifc_gtsi_delegate_spec v_addr st));
          let v_cmp2_not := (v_call1 =? (0)) in
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if v_cmp2_not
              then (
                when st == ((granule_set_state_spec v_call 1 st));
                when st == ((granule_memzero_spec v_call 1 st));
                when st == ((granule_unlock_spec v_call st));
                let v_retval_0 := 0 in
                (Some (v_retval_0, st)))
              else (
                when st == ((granule_unlock_spec v_call st));
                let v_retval_0 := 1 in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End SMCHandler_smc_granule_delegate_LowSpec.

#[global] Hint Unfold smc_granule_delegate_spec_low: spec.
