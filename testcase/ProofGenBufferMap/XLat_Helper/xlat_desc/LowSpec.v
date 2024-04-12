Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section XLat_Helper_xlat_desc_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition xlat_desc_spec_low (v_attr: Z) (v_addr_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    let v_and := (v_attr & (15)) in
    let v_cmp := (v_and =? (3)) in
    match (
      let v_desc_0 := 0 in
      let v_cmp15_not := false in
      let __retval__ := 0 in
      let __return__ := false in
      if v_cmp
      then (
        let v_retval_0 := 36028797018963968 in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__return__, __retval__, v_cmp15_not, v_desc_0, st)))
      else (
        let v_conv := v_level in
        let v_sub := (3 - (v_conv)) in
        let v_mul := (v_sub * (9)) in
        let v_add := (v_mul + (12)) in
        let v_notmask := ((- 1) << (v_add)) in
        let v_sub1 := (Z.lxor v_notmask (- 1)) in
        let v_and2 := (v_sub1 & (v_addr_pa)) in
        let v_cmp3_not := (v_and2 =? (0)) in
        match (
          let v_desc_0 := 0 in
          let v_cmp15_not := false in
          if v_cmp3_not
          then (
            let v_cmp10 := (v_level =? (3)) in
            let v_cond := (
                if v_cmp10
                then 3
                else 1) in
            when v_call, st == ((xlat_arch_get_pas_spec v_attr st));
            let v_and14 := (v_attr & (16)) in
            let v_cmp15_not := (v_and14 =? (0)) in
            let v_0 := (v_and14 << (3)) in
            let v_1 := (Z.lxor v_0 128) in
            let v_or := (v_1 |' (v_addr_pa)) in
            let v_or12 := (v_or |' (v_cond)) in
            let v_or13 := (v_or12 |' (v_call)) in
            let v_or18 := (v_or13 |' (1024)) in
            let v_and19 := (v_attr & (128)) in
            let v_cmp20_not := (v_and19 =? (0)) in
            when v_desc_0, st == (
                let v_desc_0 := 0 in
                if v_cmp20_not
                then (
                  let v_desc_0 := v_or18 in
                  (Some (v_desc_0, st)))
                else (
                  let v_or23 := (v_or13 |' (3072)) in
                  let v_desc_0 := v_or23 in
                  (Some (v_desc_0, st))));
            (Some (v_cmp15_not, v_desc_0, st)))
          else None
        ) with
        | (Some (v_cmp15_not, v_desc_0, st)) => (Some (__return__, __retval__, v_cmp15_not, v_desc_0, st))
        | None => None
        end)
    ) with
    | (Some (__return__, __retval__, v_cmp15_not, v_desc_0, st)) =>
      if __return__
      then (Some (__retval__, st))
      else (
        let v_or25 := (v_desc_0 |' (18014398509481984)) in
        let v_cmp29 := (v_and =? (0)) in
        match (
          if v_cmp29
          then (
            let v_or33 := (v_desc_0 |' (27021597764223492)) in
            let v_desc_2 := v_or33 in
            let v_retval_0 := v_desc_2 in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
          else (Some (__return__, __retval__, st))
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (Some (__retval__, st))
          else (
            match (
              if v_cmp15_not
              then (
                let v_and37 := (v_attr & (32)) in
                let v_cmp38_not := (v_and37 =? (0)) in
                match (
                  if v_cmp38_not
                  then (
                    let v_desc_1 := v_or25 in
                    let v_conv44 := (v_attr & (768)) in
                    let v_cmp47 := (v_conv44 =? (768)) in
                    when v_desc_2, st == (
                        if v_cmp47
                        then (
                          let v_desc_2 := v_desc_1 in
                          (Some (v_desc_2, st)))
                        else (
                          let v_cmp53 := (v_conv44 =? (512)) in
                          when v_desc_2, st == (
                              if v_cmp53
                              then (
                                let v_or56 := (v_desc_1 |' (512)) in
                                let v_desc_2 := v_or56 in
                                (Some (v_desc_2, st)))
                              else (
                                let v_or58 := (v_desc_1 |' (768)) in
                                let v_desc_2 := v_or58 in
                                (Some (v_desc_2, st))));
                          (Some (v_desc_2, st))));
                    let v_retval_0 := v_desc_2 in
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
                let v_or41 := (v_desc_0 |' (27021597764222976)) in
                let v_desc_1 := v_or41 in
                let v_conv44 := (v_attr & (768)) in
                let v_cmp47 := (v_conv44 =? (768)) in
                when v_desc_2, st == (
                    if v_cmp47
                    then (
                      let v_desc_2 := v_desc_1 in
                      (Some (v_desc_2, st)))
                    else (
                      let v_cmp53 := (v_conv44 =? (512)) in
                      when v_desc_2, st == (
                          if v_cmp53
                          then (
                            let v_or56 := (v_desc_1 |' (512)) in
                            let v_desc_2 := v_or56 in
                            (Some (v_desc_2, st)))
                          else (
                            let v_or58 := (v_desc_1 |' (768)) in
                            let v_desc_2 := v_or58 in
                            (Some (v_desc_2, st))));
                      (Some (v_desc_2, st))));
                let v_retval_0 := v_desc_2 in
                let __return__ := true in
                let __retval__ := v_retval_0 in
                (Some (__retval__, st)))
            | None => None
            end)
        | None => None
        end)
    | None => None
    end.

End XLat_Helper_xlat_desc_LowSpec.

#[global] Hint Unfold xlat_desc_spec_low: spec.
