Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableBlock___table_maps_block_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint __table_maps_block_loop840_low (_N_: nat) (__break__: bool) (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_retval_0: bool) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * bool * Ptr * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
    | (S _N_) =>
      match ((__table_maps_block_loop840_low _N_ __break__ v_call v_call3 v_i_015 v_level v_retval_0 v_table v_s2tte_is_x st)) with
      | (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st)) =>
        if __break__
        then (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
        else (
          rely (((v_s2tte_is_x.(poffset)) = (0)));
          rely (((v_table.(pbase)) = ("slot_rtt22")));
          rely (((((v_s2tte_is_x.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid_ns")))));
          let v_conv8 := v_i_015 in
          let v_arrayidx9 := (ptr_offset v_table ((8 * (v_conv8)) + (0))) in
          when v_call10, st == ((__tte_read_spec v_arrayidx9 st));
          when v_call11, st == ((__table_maps_block_funptr_wrap849 v_s2tte_is_x v_call10 v_level st));
          match (
            let v_mul := 0 in
            let v_inc := 0 in
            let v_exitcond := false in
            let v_cmp15_not := false in
            let v_call14 := 0 in
            let v_add := 0 in
            let __continue__ := false in
            if v_call11
            then (
              let v_mul := (v_conv8 * (v_call)) in
              let v_add := (v_mul + (v_call3)) in
              when v_call14, st == ((s2tte_pa_spec v_call10 v_level st));
              let v_cmp15_not := (v_call14 =? (v_add)) in
              let v_inc := (v_i_015 + (1)) in
              match (
                let v_exitcond := false in
                let __continue__ := false in
                if v_cmp15_not
                then (
                  let v_exitcond := (v_inc <>? (512)) in
                  match (
                    let __continue__ := false in
                    if v_exitcond
                    then (
                      let v_i_015 := v_inc in
                      let __continue__ := true in
                      (Some (__break__, __continue__, v_i_015, v_retval_0, st)))
                    else (
                      let v_retval_0 := true in
                      let __break__ := true in
                      (Some (__break__, __continue__, v_i_015, v_retval_0, st)))
                  ) with
                  | (Some (__break__, __continue__, v_i_015, v_retval_0, st)) =>
                    if __break__
                    then (Some (__break__, __continue__, v_exitcond, v_i_015, v_retval_0, st))
                    else (
                      if __continue__
                      then (Some (__break__, __continue__, v_exitcond, v_i_015, v_retval_0, st))
                      else (Some (__break__, __continue__, v_exitcond, v_i_015, v_retval_0, st)))
                  | None => None
                  end)
                else (
                  let v_retval_0 := false in
                  let __break__ := true in
                  (Some (__break__, __continue__, v_exitcond, v_i_015, v_retval_0, st)))
              ) with
              | (Some (__break__, __continue__, v_exitcond, v_i_015, v_retval_0, st)) =>
                if __break__
                then (Some (__break__, __continue__, v_add, v_call14, v_cmp15_not, v_exitcond, v_i_015, v_inc, v_mul, v_retval_0, st))
                else (
                  if __continue__
                  then (Some (__break__, __continue__, v_add, v_call14, v_cmp15_not, v_exitcond, v_i_015, v_inc, v_mul, v_retval_0, st))
                  else (Some (__break__, __continue__, v_add, v_call14, v_cmp15_not, v_exitcond, v_i_015, v_inc, v_mul, v_retval_0, st)))
              | None => None
              end)
            else (
              let v_retval_0 := false in
              let __break__ := true in
              (Some (__break__, __continue__, v_add, v_call14, v_cmp15_not, v_exitcond, v_i_015, v_inc, v_mul, v_retval_0, st)))
          ) with
          | (Some (__break__, __continue__, v_add, v_call14, v_cmp15_not, v_exitcond, v_i_015, v_inc, v_mul, v_retval_0, st)) =>
            if __break__
            then (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
            else (
              if __continue__
              then (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
              else (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Definition __table_maps_block_spec_low (v_table: Ptr) (v_level: Z) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_table.(pbase)) = ("slot_rtt2")));
    rely (((v_s2tte_is_x.(poffset)) = (0)));
    rely (((((v_s2tte_is_x.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid_ns")))));
    let v_conv := v_level in
    when v_call, st == ((s2tte_map_size_spec v_conv st));
    when v_call1, st == ((__tte_read_spec v_table st));
    when v_call2, st == ((__table_maps_block_funptr_wrap835 v_s2tte_is_x v_call1 v_level st));
    when v_retval_0, st == (
        let v_retval_0 := false in
        if v_call2
        then (
          when v_call3, st == ((s2tte_pa_spec v_call1 v_level st));
          let v_sub := (v_level + ((- 1))) in
          when v_call4, st == ((addr_is_level_aligned_spec v_call3 v_sub st));
          when v_retval_0, st == (
              let v_retval_0 := false in
              if v_call4
              then (
                let v_i_015 := 1 in
                rely (((__table_maps_block_loop840_rank v_call v_call3 v_i_015 v_level v_table v_s2tte_is_x) >= (0)));
                match (
                  (__table_maps_block_loop840_low
                    (z_to_nat (__table_maps_block_loop840_rank v_call v_call3 v_i_015 v_level v_table v_s2tte_is_x))
                    false
                    v_call
                    v_call3
                    v_i_015
                    v_level
                    false
                    v_table
                    v_s2tte_is_x
                    st)
                ) with
                | (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st)) => (Some (v_retval_0, st))
                | None => None
                end)
              else (
                let v_retval_0 := false in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := false in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End TableBlock___table_maps_block_LowSpec.

#[global] Hint Unfold __table_maps_block_loop840_low: spec.
#[global] Hint Unfold __table_maps_block_spec_low: spec.
