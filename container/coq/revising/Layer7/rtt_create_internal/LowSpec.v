Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_rtt_create_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_create_internal_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    when st == ((new_frame "rtt_create_internal" st));
    let init_st := st in
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    let v_6 := (mkPtr "stack_s_rtt_walk" 0) in
    when v_7, st == ((find_lock_granule_spec v_1 1 st));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    let v__not := (ptr_eqb v_7 (mkPtr "null" 0)) in
    match (
      let __retval__ := 0 in
      let __return__ := false in
      if v__not
      then (
        when v_9, st == ((pack_return_code_spec 1 1 st));
        let v_10 := v_9 in
        let v__0 := v_10 in
        let __return__ := true in
        let __retval__ := v__0 in
        (Some (__return__, __retval__, st)))
      else (Some (__return__, __retval__, st))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (
        when st == ((free_stack "rtt_create_internal" init_st st));
        (Some (__retval__, st)))
      else (
        when st == ((rtt_walk_lock_unlock_spec v_6 v_0 0 64 v_2 v_3 st));
        let v__sroa_0_0__sroa_idx := (ptr_offset v_6 ((24 * (0)) + ((0 + (0))))) in
        when v__sroa_0_0_copyload_tmp, st == ((load_RData 8 v__sroa_0_0__sroa_idx st));
        let v__sroa_0_0_copyload := (int_to_ptr v__sroa_0_0_copyload_tmp) in
        let v__sroa_6_0__sroa_idx16 := (ptr_offset v_6 ((24 * (0)) + ((16 + (0))))) in
        when v__sroa_6_0_copyload, st == ((load_RData 8 v__sroa_6_0__sroa_idx16 st));
        let v_12 := (v_3 + ((- 1))) in
        let v__not42 := (v__sroa_6_0_copyload =? (v_12)) in
        match (
          if v__not42
          then (Some (__return__, __retval__, st))
          else (
            let v__not43 := (v_4 =? (0)) in
            match (
              if v__not43
              then (Some (__return__, __retval__, st))
              else (
                let v_15 := (v__sroa_6_0_copyload =? (v_3)) in
                match (
                  if v_15
                  then (
                    when v_17, st == ((pack_return_code_spec 9 1234 st));
                    let v__1 := v_17 in
                    when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                    when st == ((granule_unlock_spec v_7 st));
                    let v_39 := v__1 in
                    let v__0 := v_39 in
                    let __return__ := true in
                    let __retval__ := v__0 in
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
                let v_19 := v__sroa_6_0_copyload in
                when v_20, st == ((pack_return_code_spec 8 v_19 st));
                let v__1 := v_20 in
                when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                when st == ((granule_unlock_spec v_7 st));
                let v_39 := v__1 in
                let v__0 := v_39 in
                let __return__ := true in
                let __retval__ := v__0 in
                (Some (__return__, __retval__, st)))
            | None => None
            end)
        ) with
        | (Some (__return__, __retval__, st)) =>
          if __return__
          then (
            when st == ((free_stack "rtt_create_internal" init_st st));
            (Some (__retval__, st)))
          else (
            let v__sroa_4_0__sroa_idx14 := (ptr_offset v_6 ((24 * (0)) + ((8 + (0))))) in
            when v__sroa_4_0_copyload, st == ((load_RData 8 v__sroa_4_0__sroa_idx14 st));
            when v_22, st == ((granule_map_spec v__sroa_0_0_copyload 6 st));
            let v_23 := v_22 in
            let v_24 := (ptr_offset v_23 ((8 * (v__sroa_4_0_copyload)) + (0))) in
            when v_25, st == ((__tte_read_spec v_24 st));
            when v_26, st == ((granule_map_spec v_7 1 st));
            when v_27, st == ((s2tte_is_unassigned_spec v_25 st));
            match (
              if v_27
              then (
                let v_29 := v_26 in
                when v_30, st == ((s2tte_get_ripas_spec v_25 st));
                when st == ((s2tt_init_unassigned_spec v_29 v_30 st));
                when st == ((__granule_get_spec v__sroa_0_0_copyload st));
                (Some (__return__, __retval__, st)))
              else (
                when v_32, st == ((s2tte_is_table_spec v_25 v_12 st));
                match (
                  if v_32
                  then (
                    when v_34, st == ((pack_return_code_spec 9 0 st));
                    let v__037 := v_34 in
                    let v__1 := v__037 in
                    when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                    when st == ((granule_unlock_spec v_7 st));
                    let v_39 := v__1 in
                    let v__0 := v_39 in
                    let __return__ := true in
                    let __retval__ := v__0 in
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
              then (
                when st == ((free_stack "rtt_create_internal" init_st st));
                (Some (__retval__, st)))
              else (
                when st == ((granule_set_state_spec v_7 5 st));
                when v_36, st == ((s2tte_create_table_spec v_1 v_12 st));
                when st == ((iasm_8_spec st));
                when st == ((stage1_tlbi_all_spec st));
                when st == ((__tte_write_spec v_24 v_36 st));
                when st == ((iasm_8_spec st));
                when st == ((iasm_12_isb_spec st));
                let v__037 := 0 in
                let v__1 := v__037 in
                when st == ((granule_unlock_spec v__sroa_0_0_copyload st));
                when st == ((granule_unlock_spec v_7 st));
                let v_39 := v__1 in
                let v__0 := v_39 in
                let __return__ := true in
                let __retval__ := v__0 in
                when st == ((free_stack "rtt_create_internal" init_st st));
                (Some (__retval__, st)))
            | None => None
            end)
        | None => None
        end)
    | None => None
    end.

End Layer7_rtt_create_internal_LowSpec.

#[global] Hint Unfold rtt_create_internal_spec_low: spec.
