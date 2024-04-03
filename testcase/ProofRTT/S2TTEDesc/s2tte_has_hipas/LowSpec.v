Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_s2tte_has_hipas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_has_hipas_spec_low (v_s2tte: Z) (v_hipas: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_s2tte & (3)) in
    let v_cmp_not := (v_and =? (0)) in
    match (
      let __retval__ := false in
      let __return__ := false in
      if v_cmp_not
      then (
        let v_and1 := (v_s2tte & (60)) in
        let v_cmp2_not := (v_and1 =? (v_hipas)) in
        match (
          let __retval__ := false in
          let __return__ := false in
          if v_cmp2_not
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

End S2TTEDesc_s2tte_has_hipas_LowSpec.

#[global] Hint Unfold s2tte_has_hipas_spec_low: spec.
