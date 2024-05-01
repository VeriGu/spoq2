Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section CheckFeature_access_len_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition access_len_spec_low (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((esr_sas_spec v_esr st));
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if (v_call =? (2))
        then (
          let v_retval_0 := 4 in
          (Some (v_retval_0, st)))
        else (
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if (v_call =? (0))
              then (
                let v_retval_0 := 1 in
                (Some (v_retval_0, st)))
              else (
                when v_retval_0, st == (
                    let v_retval_0 := 0 in
                    if (v_call =? (1))
                    then (
                      let v_retval_0 := 2 in
                      (Some (v_retval_0, st)))
                    else (
                      let v_retval_0 := 8 in
                      (Some (v_retval_0, st))));
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End CheckFeature_access_len_LowSpec.

#[global] Hint Unfold access_len_spec_low: spec.
