Definition xlat_read_tte_spec (v_entry1: Ptr) (st: RData) : (option (Z * RData)) :=
  when v_call, st == ((__sca_read64_spec v_entry1 st));
  let __return__ := true in
  let __retval__ := v_call in
  (Some (__retval__, st)).

Definition xlat_arch_get_max_supported_pa_spec (st: RData) : (option (Z * RData)) :=
  when v_call, st == ((arch_feat_get_pa_width_spec st));
  let v_sh_prom := v_call in
  let v_notmask := ((- 1) << (v_sh_prom)) in
  let v_sub := (Z.lxor v_notmask (- 1)) in
  let __return__ := true in
  let __retval__ := v_sub in
  (Some (__retval__, st)).

Definition xlat_get_tte_ptr_spec (v_llt: Ptr) (v_va: Z) (st: RData) : (option (Ptr * RData)) :=
  let v_llt_base_va := (ptr_offset v_llt ((24 * (0)) + ((8 + (0))))) in
  when v_0, st == ((load_RData 8 v_llt_base_va st));
  let v_cmp := (v_0 >? (v_va)) in
  when v_retval_0, st == (
      let v_retval_0 := (mkPtr "#" 0) in
      if v_cmp
      then (
        let v_retval_0 := (mkPtr "null" 0) in
        (Some (v_retval_0, st)))
      else (
        let v_sub := (v_va - (v_0)) in
        let v_level := (ptr_offset v_llt ((24 * (0)) + ((16 + (0))))) in
        when v_1, st == ((load_RData 4 v_level st));
        let v_conv := v_1 in
        let v_sub2 := (3 - (v_conv)) in
        let v_mul := (v_sub2 * (9)) in
        let v_add := (v_mul + (12)) in
        let v_shr := (v_sub >> (v_add)) in
        let v_conv4 := (v_shr & (4294967295)) in
        let v_cmp5 := (v_conv4 <? (512)) in
        when v_cond, st == (
            let v_cond := (mkPtr "#" 0) in
            if v_cmp5
            then (
              let v_table := (ptr_offset v_llt ((24 * (0)) + ((0 + (0))))) in
              when v_2_tmp, st == ((load_RData 8 v_table st));
              let v_2 := (int_to_ptr v_2_tmp) in
              let v_arrayidx := (ptr_offset v_2 ((8 * (v_conv4)) + (0))) in
              let v_cond := v_arrayidx in
              (Some (v_cond, st)))
            else (
              let v_cond := (mkPtr "null" 0) in
              (Some (v_cond, st))));
        let v_retval_0 := v_cond in
        (Some (v_retval_0, st))));
  let __return__ := true in
  let __retval__ := v_retval_0 in
  (Some (__retval__, st)).

Definition xlat_desc_spec (v_attr: Z) (v_addr_pa: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
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

Definition xlat_write_tte_spec (v_entry1: Ptr) (v_desc: Z) (st: RData) : (option RData) :=
  when st == ((__sca_write64_spec v_entry1 v_desc st));
  let __return__ := true in
  (Some st).

