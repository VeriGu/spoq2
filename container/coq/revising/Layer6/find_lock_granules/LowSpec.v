Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_find_lock_granules_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granules_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    let v_4 := (ptr_offset v_0 ((40 * (0)) + ((0 + (0))))) in
    rely (((v_4.(pbase)) = ("stack_type_6")));
    rely (((v_4.(poffset)) = (0)));
    when st == ((store_RData 4 v_4 0 st));
    let v_5 := (ptr_offset v_0 ((40 * (1)) + ((0 + (0))))) in
    rely (((v_5.(pbase)) = ("stack_type_6")));
    rely (((v_5.(poffset)) = (40)));
    when st == ((store_RData 4 v_5 1 st));
    when st == ((sort_granules_spec v_0 2 st));
    match (
      let __retval__ := 0 in
      let __return__ := false in
      (Some (__return__, __retval__, st))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (Some (__retval__, st))
      else (
        let v_11 := (ptr_offset v_0 ((40 * (0)) + ((8 + (0))))) in
        rely (((v_11.(pbase)) = ("stack_type_6")));
        when v_12, st == ((load_RData 8 v_11 st));
        let v_13 := (ptr_offset v_0 ((40 * (0)) + ((16 + (0))))) in
        rely (((v_13.(pbase)) = ("stack_type_6")));
        when v_14, st == ((load_RData 4 v_13 st));
        when v_15, st == ((find_lock_granule_spec v_12 v_14 st));
        rely ((((v_15.(pbase)) =s ("granules")) \/ (((v_15.(pbase)) =s ("null")))));
        rely (((v_15.(poffset)) >= (0)));
        rely ((((v_15.(pbase)) =s ("null")) \/ (((v_15.(poffset)) <? ((GRANULE_SIZE * (NR_GRANULES)))))));
        let v_16 := (ptr_offset v_0 ((40 * (0)) + ((24 + (0))))) in
        rely (((v_16.(pbase)) = ("stack_type_6")));
        when st == ((store_RData 8 v_16 (ptr_to_int v_15) st));
        let v__not := (ptr_eqb v_15 (mkPtr "null" 0)) in
        match (
          let v__1_lcssa_wide := 0 in
          let v__1_lcssa47_wide := 0 in
          if v__not
          then (
            let v__1_lcssa_wide := 0 in
            let v__1_lcssa47_wide := 0 in
            (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
          else (
            match (
              if true
              then (
                let v_26 := (ptr_offset v_0 ((40 * (1)) + ((8 + (0))))) in
                rely (((v_26.(pbase)) = ("stack_type_6")));
                when v_27, st == ((load_RData 8 v_26 st));
                let v_28 := (ptr_offset v_0 ((40 * (0)) + ((8 + (0))))) in
                rely (((v_28.(pbase)) = ("stack_type_6")));
                when v_29, st == ((load_RData 8 v_28 st));
                let v_30 := (v_27 =? (v_29)) in
                match (
                  if v_30
                  then (
                    when v_9, st == ((make_return_code_spec 3 0 st));
                    let v__148 := 1 in
                    let v__sroa_02_0 := v_9 in
                    let v_49 := (v__148 >? (0)) in
                    when st == (
                        if v_49
                        then (
                          let v_50 := v__148 in
                          let v_51 := (v_50 + ((- 1))) in
                          let v_53 := (ptr_offset v_0 ((40 * (v_51)) + ((24 + (0))))) in
                          rely (((v_53.(pbase)) = ("stack_type_6")));
                          when v_54_tmp, st == ((load_RData 8 v_53 st));
                          rely ((v_54_tmp >= (GRANULES_BASE)));
                          rely ((v_54_tmp < (RMM_ATTEST_SIGNING_KEY_BASE)));
                          rely (((v_54_tmp mod (16)) = (0)));
                          let v_54 := (int_to_ptr v_54_tmp) in
                          rely (((v_54.(pbase)) = ("granules")));
                          when st == ((granule_unlock_spec v_54 st));
                          (Some st))
                        else (Some st));
                    let v__sroa_039_0_insert_insert := v__sroa_02_0 in
                    let __return__ := true in
                    let __retval__ := v__sroa_039_0_insert_insert in
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
              then (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
              else (
                let v_32 := (ptr_offset v_0 ((40 * (1)) + ((8 + (0))))) in
                when v_33, st == ((load_RData 8 v_32 st));
                let v_34 := (ptr_offset v_0 ((40 * (1)) + ((16 + (0))))) in
                when v_35, st == ((load_RData 4 v_34 st));
                when v_36, st == ((find_lock_granule_spec v_33 v_35 st));
                rely ((((v_36.(pbase)) =s ("granules")) \/ (((v_36.(pbase)) =s ("null")))));
                rely (((v_36.(poffset)) >= (0)));
                rely ((((v_36.(pbase)) =s ("null")) \/ (((v_36.(poffset)) <? ((GRANULE_SIZE * (NR_GRANULES)))))));
                let v_37 := (ptr_offset v_0 ((40 * (1)) + ((24 + (0))))) in
                when st == ((store_RData 8 v_37 (ptr_to_int v_36) st));
                let v__not_1 := (ptr_eqb v_36 (mkPtr "null" 0)) in
                match (
                  let v__1_lcssa_wide := 0 in
                  let v__1_lcssa47_wide := 0 in
                  if v__not_1
                  then (
                    let v__1_lcssa_wide := 1 in
                    let v__1_lcssa47_wide := 1 in
                    (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
                  else (
                    let v_40 := (ptr_offset v_0 ((40 * (0)) + ((24 + (0))))) in
                    when v_41_tmp, st == ((load_RData 8 v_40 st));
                    let v_43 := (mkPtr "stack_type_4" 0) in
                    when st == ((store_RData 8 v_43 v_41_tmp st));
                    let v_44 := (ptr_offset v_0 ((40 * (1)) + ((24 + (0))))) in
                    when v_45_tmp, st == ((load_RData 8 v_44 st));
                    let v_47 := (mkPtr "stack_type_4__1" 0) in
                    when st == ((store_RData 8 v_47 v_45_tmp st));
                    let v__sroa_039_0_insert_insert := 0 in
                    let __return__ := true in
                    let __retval__ := v__sroa_039_0_insert_insert in
                    (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
                ) with
                | (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)) =>
                  if __return__
                  then (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
                  else (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
                | None => None
                end)
            | None => None
            end)
        ) with
        | (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)) =>
          if __return__
          then (Some (__retval__, st))
          else (
            let v_18 := v__1_lcssa47_wide in
            let v_19 := v__1_lcssa_wide in
            let v_20 := v_19 in
            let v_21 := (ptr_offset v_0 ((40 * (v_20)) + ((0 + (0))))) in
            when v_22, st == ((load_RData 4 v_21 st));
            when v_23, st == ((make_return_code_spec 1 v_22 st));
            let v__148 := v_18 in
            let v__sroa_02_0 := v_23 in
            let v_49 := (v__148 >? (0)) in
            when st == (
                if v_49
                then (
                  let v_50 := v__148 in
                  let v_51 := (v_50 + ((- 1))) in
                  let v_53 := (ptr_offset v_0 ((40 * (v_51)) + ((24 + (0))))) in
                  rely (((v_53.(pbase)) = ("stack_type_6")));
                  when v_54_tmp, st == ((load_RData 8 v_53 st));
                  rely ((v_54_tmp >= (GRANULES_BASE)));
                  rely ((v_54_tmp < (RMM_ATTEST_SIGNING_KEY_BASE)));
                  rely (((v_54_tmp mod (16)) = (0)));
                  let v_54 := (int_to_ptr v_54_tmp) in
                  rely (((v_54.(pbase)) = ("granules")));
                  when st == ((granule_unlock_spec v_54 st));
                  (Some st))
                else (Some st));
            let v__sroa_039_0_insert_insert := v__sroa_02_0 in
            let __return__ := true in
            let __retval__ := v__sroa_039_0_insert_insert in
            (Some (__retval__, st)))
        | None => None
        end)
    | None => None
    end.

End Layer6_find_lock_granules_LowSpec.

#[global] Hint Unfold find_lock_granules_spec_low: spec.
