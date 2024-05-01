Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEPA.Spec.
Require Import S2TTEState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEOps_update_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition update_ripas_spec_low (v_s2tte: Ptr) (v_level: Z) (v_ripas: Z) (st: RData) : (option (bool * RData)) :=
    rely (((v_s2tte.(pbase)) = ("smc_rtt_set_ripas_stack")));
    when v_0, st == ((load_RData 8 v_s2tte st));
    when v_call, st == ((s2tte_is_table_spec v_0 v_level st));
    match (
      let __retval__ := false in
      let __return__ := false in
      if v_call
      then (
        let v_retval_0 := false in
        let __return__ := true in
        let __retval__ := v_retval_0 in
        (Some (__return__, __retval__, st)))
      else (
        when v_1, st == ((load_RData 8 v_s2tte st));
        when v_call1, st == ((s2tte_is_valid_spec v_1 v_level st));
        match (
          let __retval__ := false in
          let __return__ := false in
          if v_call1
          then (
            let v_cmp := (v_ripas =? (0)) in
            when st == (
                if v_cmp
                then (
                  when v_2, st == ((load_RData 8 v_s2tte st));
                  when v_call4, st == ((s2tte_pa_spec v_2 v_level st));
                  when v_call5, st == ((s2tte_create_assigned_empty_spec v_call4 v_level st));
                  when st == ((store_RData 8 v_s2tte v_call5 st));
                  (Some st))
                else (Some st));
            let v_retval_0 := true in
            let __return__ := true in
            let __retval__ := v_retval_0 in
            (Some (__return__, __retval__, st)))
          else (
            when v_3, st == ((load_RData 8 v_s2tte st));
            when v_call8, st == ((s2tte_is_unassigned_spec v_3 st));
            match (
              let __retval__ := false in
              let __return__ := false in
              if v_call8
              then (Some (__return__, __retval__, st))
              else (
                when v_4, st == ((load_RData 8 v_s2tte st));
                when v_call9, st == ((s2tte_is_assigned_spec v_4 v_level st));
                match (
                  let __retval__ := false in
                  let __return__ := false in
                  if v_call9
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
                when v_call11, st == ((s2tte_create_ripas_spec v_ripas st));
                when v_5, st == ((load_RData 8 v_s2tte st));
                let v_or := (v_5 |' (v_call11)) in
                when st == ((store_RData 8 v_s2tte v_or st));
                let v_retval_0 := true in
                let __return__ := true in
                let __retval__ := v_retval_0 in
                (Some (__return__, __retval__, st)))
            | None => None
            end)
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
      then (Some (__retval__, st))
      else (Some (__retval__, st))
    | None => None
    end.

End S2TTEOps_update_ripas_LowSpec.

#[global] Hint Unfold update_ripas_spec_low: spec.
