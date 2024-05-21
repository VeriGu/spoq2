Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_data_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_data_create_spec_low (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_src_addr: Z) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
    let v__not := (v_flags <? (2)) in
    match (
      let __retval__ := 0 in
      let __return__ := false in
      if v__not
      then (
        when v_call, st == ((find_granule_spec v_src_addr st));
        let v_cmp2 := (ptr_eqb v_call (mkPtr "null" 0)) in
        match (
          let __retval__ := 0 in
          let __return__ := false in
          if v_cmp2
          then (Some (__return__, __retval__, st))
          else (
            let v_state := (ptr_offset v_call ((16 * (0)) + ((4 + (0))))) in
            when v_0, st == ((load_RData 4 v_state st));
            let v_cmp3_not := (v_0 =? (0)) in
            match (
              let __retval__ := 0 in
              let __return__ := false in
              if v_cmp3_not
              then (
                when v_call6, st == ((data_create_spec v_data_addr v_rd_addr v_map_addr v_call v_flags st));
                let v_retval_0 := v_call6 in
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
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (Some (__return__, __retval__, st))
          else (
            let v_retval_0 := 1 in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
        | None => None
        end)
      else (
        let v_retval_0 := 1 in
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

End SMCHandler_smc_data_create_LowSpec.

#[global] Hint Unfold smc_data_create_spec_low: spec.
