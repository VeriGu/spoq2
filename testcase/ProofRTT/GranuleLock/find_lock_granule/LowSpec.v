Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleLock_find_lock_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granule_spec_low (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st == ((find_granule_spec v_addr st));
    let v_cmp := (ptr_eqb v_call (mkPtr "null" 0)) in
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_cmp
        then (
          let v_retval_0 := (mkPtr "null" 0) in
          (Some (v_retval_0, st)))
        else (
          when v_call1, st == ((granule_lock_on_state_match_spec v_call v_expected_state st));
          when v_retval_0, st == (
              let v_retval_0 := (mkPtr "#" 0) in
              if v_call1
              then (
                let v_retval_0 := v_call in
                (Some (v_retval_0, st)))
              else (
                let v_retval_0 := (mkPtr "null" 0) in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End GranuleLock_find_lock_granule_LowSpec.

#[global] Hint Unfold find_lock_granule_spec_low: spec.
