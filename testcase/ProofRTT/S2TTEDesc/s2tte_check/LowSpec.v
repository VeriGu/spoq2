Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc_s2tte_check_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_check_spec_low (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : (option (bool * RData)) :=
    let v_and := (v_s2tte & (36028797018963968)) in
    let v_cmp_not := (v_and =? (v_ns)) in
    match (
      let __retval__ := false in
      let __return__ := false in
      if v_cmp_not
      then (
        let v_and1 := (v_s2tte & (3)) in
        let v_cmp2 := (v_level =? (3)) in
        let v_cmp3 := (v_and1 =? (3)) in
        let v_or_cond := (v_cmp2 && (v_cmp3)) in
        match (
          let __retval__ := false in
          let __return__ := false in
          if v_or_cond
          then (Some (__return__, __retval__, st))
          else (
            let v_cmp4 := (v_level =? (2)) in
            let v_cmp6 := (v_and1 =? (1)) in
            let v_or_cond1 := (v_cmp4 && (v_cmp6)) in
            match (
              let __retval__ := false in
              let __return__ := false in
              if v_or_cond1
              then (Some (__return__, __retval__, st))
              else (
                let v_retval_0 := false in
                let __return__ := true in
                let __retval__ := v_retval_0 in
                (Some (__return__, __retval__, st)))
            ) with
            | (Some (__return__, __retval__, st)) =>
              if __return__
              then (Some (__return__, __retval__, st))
              else (Some (__return__, __retval__, st))
            | None => None
            end)
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (Some (__return__, __retval__, st))
          else (
            let v_retval_0 := true in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
        | None => None
        end)
      else (
        let v_retval_0 := false in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__return__, __retval__, st)))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (Some (__retval__, st))
      else (Some (__retval__, st))
    | None => None
    end.

End S2TTEDesc_s2tte_check_LowSpec.

#[global] Hint Unfold s2tte_check_spec_low: spec.
