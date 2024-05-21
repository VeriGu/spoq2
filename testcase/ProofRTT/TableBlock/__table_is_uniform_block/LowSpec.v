Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableBlock___table_is_uniform_block_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint __table_is_uniform_block_loop777_low (_N_: nat) (__break__: bool) (v_cmp_not: bool) (v_indvars_iv: Z) (v_retval_0: bool) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * bool * Z * bool * Z * Ptr * Ptr * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
    | (S _N_) =>
      match ((__table_is_uniform_block_loop777_low _N_ __break__ v_cmp_not v_indvars_iv v_retval_0 v_ripas_0 v_ripas_ptr v_table v_s2tte_is_x st)) with
      | (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st)) =>
        if __break__
        then (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
        else (
          rely (((v_ripas_ptr.(pbase)) = ("smc_rtt_fold_stack")));
          rely (((v_s2tte_is_x.(poffset)) = (0)));
          rely (((v_table.(pbase)) = ("slot_rtt2")));
          rely ((((v_s2tte_is_x.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_destroyed")))));
          let v_arrayidx6 := (ptr_offset v_table ((8 * (v_indvars_iv)) + (0))) in
          when v_call7, st == ((__tte_read_spec v_arrayidx6 st));
          when v_call8, st == ((__table_is_uniform_block_funptr_wrap788 v_s2tte_is_x v_call7 st));
          match (
            let v_indvars_iv_next := 0 in
            let v_exitcond := false in
            let v_cmp13_not := false in
            let v_call12 := 0 in
            let __continue__ := false in
            if v_call8
            then (
              match (
                let v_cmp13_not := false in
                let v_call12 := 0 in
                if v_cmp_not
                then (Some (__break__, v_call12, v_cmp13_not, v_retval_0, st))
                else (
                  when v_call12, st == ((s2tte_get_ripas_spec v_call7 st));
                  let v_cmp13_not := (v_call12 =? (v_ripas_0)) in
                  match (
                    if v_cmp13_not
                    then (Some (__break__, v_retval_0, st))
                    else (
                      let v_retval_0 := false in
                      let __break__ := true in
                      (Some (__break__, v_retval_0, st)))
                  ) with
                  | (Some (__break__, v_retval_0, st)) =>
                    if __break__
                    then (Some (__break__, v_call12, v_cmp13_not, v_retval_0, st))
                    else (Some (__break__, v_call12, v_cmp13_not, v_retval_0, st))
                  | None => None
                  end)
              ) with
              | (Some (__break__, v_call12, v_cmp13_not, v_retval_0, st)) =>
                if __break__
                then (Some (__break__, __continue__, v_call12, v_cmp13_not, v_exitcond, v_indvars_iv, v_indvars_iv_next, v_retval_0, st))
                else (
                  let v_indvars_iv_next := (v_indvars_iv + (1)) in
                  let v_exitcond := (v_indvars_iv_next <>? (512)) in
                  match (
                    let __continue__ := false in
                    if v_exitcond
                    then (
                      let v_indvars_iv := v_indvars_iv_next in
                      let __continue__ := true in
                      (Some (__break__, __continue__, v_indvars_iv, v_retval_0, st)))
                    else (
                      when st == (
                          if v_cmp_not
                          then (Some st)
                          else (
                            when st == ((store_RData 4 v_ripas_ptr v_ripas_0 st));
                            (Some st)));
                      let v_retval_0 := true in
                      let __break__ := true in
                      (Some (__break__, __continue__, v_indvars_iv, v_retval_0, st)))
                  ) with
                  | (Some (__break__, __continue__, v_indvars_iv, v_retval_0, st)) =>
                    if __break__
                    then (Some (__break__, __continue__, v_call12, v_cmp13_not, v_exitcond, v_indvars_iv, v_indvars_iv_next, v_retval_0, st))
                    else (
                      if __continue__
                      then (Some (__break__, __continue__, v_call12, v_cmp13_not, v_exitcond, v_indvars_iv, v_indvars_iv_next, v_retval_0, st))
                      else (Some (__break__, __continue__, v_call12, v_cmp13_not, v_exitcond, v_indvars_iv, v_indvars_iv_next, v_retval_0, st)))
                  | None => None
                  end)
              | None => None
              end)
            else (
              let v_retval_0 := false in
              let __break__ := true in
              (Some (__break__, __continue__, v_call12, v_cmp13_not, v_exitcond, v_indvars_iv, v_indvars_iv_next, v_retval_0, st)))
          ) with
          | (Some (__break__, __continue__, v_call12, v_cmp13_not, v_exitcond, v_indvars_iv, v_indvars_iv_next, v_retval_0, st)) =>
            if __break__
            then (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
            else (
              if __continue__
              then (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
              else (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Definition __table_is_uniform_block_spec_low (v_table: Ptr) (v_s2tte_is_x: Ptr) (v_ripas_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_s2tte_is_x.(poffset)) = (0)));
    rely (((v_table.(pbase)) = ("slot_rtt2")));
    rely ((((v_s2tte_is_x.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_destroyed")))));
    when v_call, st == ((__tte_read_spec v_table st));
    when v_call1, st == ((__table_is_uniform_block_funptr_wrap777 v_s2tte_is_x v_call st));
    when v_retval_0, st == (
        let v_retval_0 := false in
        if v_call1
        then (
          let v_cmp_not := (ptr_eqb v_ripas_ptr (mkPtr "null" 0)) in
          when v_ripas_0, st == (
              let v_ripas_0 := 0 in
              if v_cmp_not
              then (
                let v_ripas_0 := 0 in
                (Some (v_ripas_0, st)))
              else (
                when v_call3, st == ((s2tte_get_ripas_spec v_call st));
                let v_ripas_0 := v_call3 in
                (Some (v_ripas_0, st))));
          let v_indvars_iv := 1 in
          rely (((__table_is_uniform_block_loop777_rank v_cmp_not v_indvars_iv v_ripas_0 v_ripas_ptr v_table v_s2tte_is_x) >= (0)));
          match (
            (__table_is_uniform_block_loop777_low
              (z_to_nat (__table_is_uniform_block_loop777_rank v_cmp_not v_indvars_iv v_ripas_0 v_ripas_ptr v_table v_s2tte_is_x))
              false
              v_cmp_not
              v_indvars_iv
              false
              v_ripas_0
              v_ripas_ptr
              v_table
              v_s2tte_is_x
              st)
          ) with
          | (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st)) => (Some (v_retval_0, st))
          | None => None
          end)
        else (
          let v_retval_0 := false in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End TableBlock___table_is_uniform_block_LowSpec.

#[global] Hint Unfold __table_is_uniform_block_loop777_low: spec.
#[global] Hint Unfold __table_is_uniform_block_spec_low: spec.
