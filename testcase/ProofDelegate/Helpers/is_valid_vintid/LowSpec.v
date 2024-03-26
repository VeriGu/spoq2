Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_is_valid_vintid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition is_valid_vintid_spec_low (v_intid: Z) (st: RData) : (option (bool * RData)) :=
    let v_cmp := (v_intid <? (1020)) in
    match (
      let __retval__ := false in
      let __return__ := false in
      if v_cmp
      then (
        let v_retval_0 := true in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__return__, __retval__, st)))
      else (
        let v_cmp1 := (v_intid >? (8191)) in
        match (
          let __retval__ := false in
          let __return__ := false in
          if v_cmp1
          then (
            when v_0, st == ((load_RData 8 (mkPtr "gic_virt_feature_3" 0) st));
            let v_cmp2_not := (v_0 <? (v_intid)) in
            match (
              let __retval__ := false in
              let __return__ := false in
              if v_cmp2_not
              then (Some (__return__, __retval__, st))
              else (
                let v_retval_0 := true in
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
          else (Some (__return__, __retval__, st))
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (Some (__return__, __retval__, st))
          else (
            when v_1, st == ((load_RData 1 (mkPtr "gic_virt_feature_4" 0) st));
            let v_2 := (v_1 & (1)) in
            let v_tobool_not := (v_2 =? (0)) in
            when v_cond, st == (
                let v_cond := false in
                if v_tobool_not
                then (
                  let v_cond := false in
                  (Some (v_cond, st)))
                else (
                  let v_3 := (v_intid + (18446744073709550560)) in
                  let v_4 := (v_3 <? (64)) in
                  when v_7, st == (
                      let v_7 := false in
                      if v_4
                      then (
                        let v_7 := true in
                        (Some (v_7, st)))
                      else (
                        let v_5 := (v_intid & (18446744073709550592)) in
                        let v_6 := (v_5 =? (4096)) in
                        let v_7 := v_6 in
                        (Some (v_7, st))));
                  let v_cond := v_7 in
                  (Some (v_cond, st))));
            let v_retval_0 := v_cond in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
        | None => None
        end)
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (Some (__retval__, st))
      else (Some (__retval__, st))
    | None => None
    end.

End Helpers_is_valid_vintid_LowSpec.

#[global] Hint Unfold is_valid_vintid_spec_low: spec.
