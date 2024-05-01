Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section FindGranule_find_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_granule_spec_low (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    let v_rem := (v_addr & (4095)) in
    let v_cmp := (v_rem =? (0)) in
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_cmp
        then (
          when v_call, st == ((plat_granule_addr_to_idx_spec v_addr st));
          let v_cmp1 := (v_call >? (1048575)) in
          when v_retval_0, st == (
              let v_retval_0 := (mkPtr "#" 0) in
              if v_cmp1
              then (
                let v_retval_0 := (mkPtr "null" 0) in
                (Some (v_retval_0, st)))
              else (
                when v_call4, st == ((granule_from_idx_spec v_call st));
                let v_retval_0 := v_call4 in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := (mkPtr "null" 0) in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End FindGranule_find_granule_LowSpec.

#[global] Hint Unfold find_granule_spec_low: spec.
