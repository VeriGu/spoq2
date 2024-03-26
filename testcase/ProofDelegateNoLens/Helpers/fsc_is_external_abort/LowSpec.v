Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_fsc_is_external_abort_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition fsc_is_external_abort_spec_low (v_fsc: Z) (st: RData) : (option (bool * RData)) :=
    let v_cmp := (v_fsc =? (16)) in
    when v_retval_0, st == (
        let v_retval_0 := false in
        if v_cmp
        then (
          let v_retval_0 := true in
          (Some (v_retval_0, st)))
        else (
          let v_0 := (v_fsc + ((- 19))) in
          let v_1 := (v_0 <? (5)) in
          when v_retval_0, st == (
              let v_retval_0 := false in
              if v_1
              then (
                let v_retval_0 := true in
                (Some (v_retval_0, st)))
              else (
                let v_retval_0 := false in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End Helpers_fsc_is_external_abort_LowSpec.

#[global] Hint Unfold fsc_is_external_abort_spec_low: spec.
