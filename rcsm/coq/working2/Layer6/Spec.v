Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_walk_lock_unlock_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rtt_walk_lock_unlock" st));
    rely (((((v_1.(pbase)) = ("granules")) /\ ((((v_1.(poffset)) mod (16)) = (0)))) /\ (((v_1.(poffset)) >= (0)))));
    rely (((((v_0.(pbase)) = ("stack_s_rtt_walk")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_1 == ((llvm_memset_p0i8_i64_spec (mkPtr "stack_type_5" 0) 0 32 false st_0));
    when st_2 == ((llvm_memset_p0i8_i64_spec v_0 0 24 false st_1));
    when v_10, st_3 == ((s2_sl_addr_to_idx_spec v_4 v_2 v_3 st_2));
    if (v_10 >? (511))
    then (
      when st_4 == ((granule_lock_spec (ptr_offset v_1 (16 * (((v_10 >> (9)) & (4294967295))))) 5 st_3));
      when st_5 == ((granule_unlock_spec v_1 st_4));
      rely ((((0 - (v_2)) <= (0)) /\ ((v_2 < (4)))));
      when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_2))) (ptr_to_int (ptr_offset v_1 (16 * (((v_10 >> (9)) & (4294967295)))))) st_5));
      if ((v_2 - (v_5)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop467
            (z_to_nat (rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2))
            false
            false
            v_0
            v_4
            v_5
            (mkPtr "stack_type_5" 0)
            v_2
            st_7)
        ) with
        | (Some (__return___0, __break__, v_14, v_13, v_6, v_12, v_indvars_iv_0, st_8)) =>
          if __return___0
          then (
            when st_10 == ((free_stack "rtt_walk_lock_unlock" st_0 st_8));
            (Some st_10))
          else (
            when st_10 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_8));
            rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
            when v_37_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_11));
            when v_39, st_13 == ((s2_addr_to_idx_spec v_4 v_5 st_12));
            when st_14 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_13));
            when st_15 == ((free_stack "rtt_walk_lock_unlock" st_0 st_14));
            (Some st_15))
        | None => None
        end)
      else (
        when st_9 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_7));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
        when v_37_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_10));
        when v_39, st_12 == ((s2_addr_to_idx_spec v_4 v_5 st_11));
        when st_13 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_12));
        when st_14 == ((free_stack "rtt_walk_lock_unlock" st_0 st_13));
        (Some st_14)))
    else (
      rely ((((0 - (v_2)) <= (0)) /\ ((v_2 < (4)))));
      when st_5 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_2))) (ptr_to_int v_1) st_3));
      if ((v_2 - (v_5)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop467
            (z_to_nat (rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2))
            false
            false
            v_0
            v_4
            v_5
            (mkPtr "stack_type_5" 0)
            v_2
            st_5)
        ) with
        | (Some (__return___0, __break__, v_14, v_13, v_6, v_12, v_indvars_iv_0, st_6)) =>
          if __return___0
          then (
            when st_8 == ((free_stack "rtt_walk_lock_unlock" st_0 st_6));
            (Some st_8))
          else (
            when st_8 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_6));
            rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
            when v_37_tmp, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_8));
            when st_10 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_9));
            when v_39, st_11 == ((s2_addr_to_idx_spec v_4 v_5 st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_11));
            when st_13 == ((free_stack "rtt_walk_lock_unlock" st_0 st_12));
            (Some st_13))
        | None => None
        end)
      else (
        when st_7 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_5));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
        when v_37_tmp, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_7));
        when st_9 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_8));
        when v_39, st_10 == ((s2_addr_to_idx_spec v_4 v_5 st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_10));
        when st_12 == ((free_stack "rtt_walk_lock_unlock" st_0 st_11));
        (Some st_12))).

  Fixpoint rtt_walk_lock_unlock_loop467 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_4, v_5, v_7, v_indvars_iv, st))
    | (S _N__0) =>
      match ((rtt_walk_lock_unlock_loop467 _N__0 __return__ __break__ v_0 v_4 v_5 v_7 v_indvars_iv st)) with
      | (Some (return___9, break___9, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9)) =>
        if break___9
        then (Some (return___9, true, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9))
        else (
          if return___9
          then (Some (true, false, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9))
          else (
            rely ((((0 - (v_indvars_iv_9)) <= (0)) /\ ((v_indvars_iv_9 < (4)))));
            when v_23_tmp, st_10 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_9));
            when v_38, st_11 == ((__find_lock_next_level_spec (int_to_ptr v_23_tmp) v_37 v_indvars_iv_9 st_10));
            rely ((((0 - ((v_indvars_iv_9 + (1)))) <= (0)) /\ (((v_indvars_iv_9 + (1)) < (4)))));
            when st_12 == ((store_RData 8 (ptr_offset v_36 (8 * ((v_indvars_iv_9 + (1))))) (ptr_to_int v_38) st_11));
            if (ptr_eqb v_38 (mkPtr "null" 0))
            then (
              when st_13 == ((store_RData 8 (ptr_offset v_13 16) v_indvars_iv_9 st_12));
              when v_37_tmp, st_16 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_13));
              when st_17 == ((store_RData 8 (ptr_offset v_13 0) v_37_tmp st_16));
              when v_40, st_18 == ((s2_addr_to_idx_spec v_37 v_indvars_iv_9 st_17));
              when st_20 == ((store_RData 8 (ptr_offset v_13 8) v_40 st_18));
              (Some (true, false, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_20)))
            else (
              when v_29_tmp, st_13 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_12));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_13));
              if (((v_indvars_iv_9 + (1)) - (v_31)) <? (0))
              then (Some (false, false, v_13, v_37, v_31, v_36, (v_indvars_iv_9 + (1)), st_16))
              else (Some (false, true, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_16)))))
      | None => None
      end
    end.

  Definition find_lock_granules_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
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
        rely ((((v_15.(pbase)) = ("granules")) \/ (((v_15.(pbase)) = ("null")))));
        rely (((v_15.(poffset)) >= (0)));
        rely ((((v_15.(pbase)) = ("null")) \/ (((v_15.(poffset)) < ((GRANULE_SIZE * (NR_GRANULES)))))));
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

  Definition s2tt_init_unassigned_loop759_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
    0.

  Definition s2tt_init_unassigned_loop759_0_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
    0.

  Definition granule_set_state_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (6)))));
    (Some (lens 83 st)).

  Definition pack_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((((v_1 << (32)) + (v_0)) >> (24)) & (4294967040)) |' (((v_1 << (32)) + (v_0)))), st)).

  Definition g_refcount_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    (Some ((((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)), st)).

End Layer6_Spec.

Opaque rtt_walk_lock_unlock_spec.
#[global] Hint Unfold rtt_walk_lock_unlock_loop467: spec.
#[global] Hint Unfold find_lock_granules_spec: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_rank: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_0_rank: spec.
#[global] Hint Unfold granule_set_state_spec: spec.
#[global] Hint Unfold pack_return_code_spec: spec.
#[global] Hint Unfold g_refcount_spec: spec.
