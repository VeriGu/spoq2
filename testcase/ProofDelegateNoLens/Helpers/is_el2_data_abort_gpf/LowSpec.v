Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_is_el2_data_abort_gpf_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition is_el2_data_abort_gpf_spec_low (v_esr: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_esr & (4227858432)) in
    let v_cmp := (v_and =? (2483027968)) in
    match (
      let __retval__ := false in
      let __return__ := false in
      if v_cmp
      then (
        let v_and1 := (v_esr & (63)) in
        let v_cmp2 := (v_and1 =? (40)) in
        match (
          let __retval__ := false in
          let __return__ := false in
          if v_cmp2
          then (
            let v_retval_0 := true in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
          else (Some (__return__, __retval__, st))
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (Some (__return__, __retval__, st))
          else (Some (__return__, __retval__, st))
        | None => None
        end)
      else (Some (__return__, __retval__, st))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (Some (__retval__, st))
      else (
        let v_retval_0 := false in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__retval__, st)))
    | None => None
    end.

End Helpers_is_el2_data_abort_gpf_LowSpec.

#[global] Hint Unfold is_el2_data_abort_gpf_spec_low: spec.
