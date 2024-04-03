Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section LockGranules_find_lock_unused_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_unused_granule_spec_low (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st == ((find_lock_granule_spec v_addr v_expected_state st));
    let v_cmp := (ptr_eqb v_call (mkPtr "null" 0)) in
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_cmp
        then (
          when v_call1, st == ((status_ptr_spec 1 st));
          let v_0 := v_call1 in
          let v_retval_0 := v_0 in
          (Some (v_retval_0, st)))
        else (
          when v_call2, st == ((granule_refcount_read_acquire_spec v_call st));
          let v_tobool_not := (v_call2 =? (0)) in
          when v_retval_0, st == (
              let v_retval_0 := (mkPtr "#" 0) in
              if v_tobool_not
              then (
                let v_retval_0 := v_call in
                (Some (v_retval_0, st)))
              else (
                when st == ((granule_unlock_spec v_call st));
                when v_call4, st == ((status_ptr_spec 5 st));
                let v_1 := v_call4 in
                let v_retval_0 := v_1 in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End LockGranules_find_lock_unused_granule_LowSpec.

#[global] Hint Unfold find_lock_unused_granule_spec_low: spec.
