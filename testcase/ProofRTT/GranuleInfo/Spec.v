Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section GranuleInfo_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granules_loop197_rank (v_granules: Ptr) (v_i_241: Z) : Z :=
    (2 - (v_i_241)).

  Definition find_lock_granules_loop0_rank (v_granules: Ptr) (v_i_143: Z) : Z :=
    (2 - (v_i_143)).

  Definition get_cached_llt_info_spec (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (Some ((mkPtr "llt_info_cache" (24 * (CPU_ID))), st)).

  Definition slot_to_va_spec (v_slot: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_slot << (12)) + (18446744073709420544)), st)).

  Definition granule_unlock_transition_spec (v_g: Ptr) (v_new_state: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end)
    then (
      when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
      (Some (lens 1157 st)))
    else None.

  Fixpoint find_lock_granules_loop197 (_N_: nat) (__break__: bool) (v_granules: Ptr) (v_i_241: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_granules, v_i_241, st))
    | (S _N_) =>
      match ((find_lock_granules_loop197 _N_ __break__ v_granules v_i_241 st)) with
      | (Some (__break__, v_granules, v_i_241, st)) =>
        rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
        if __break__
        then (Some (__break__, v_granules, v_i_241, st))
        else (
          let v_g30 := (ptr_offset v_granules ((40 * (v_i_241)) + ((24 + (0))))) in
          when v_6_tmp, st == ((load_RData 8 v_g30 st));
          let v_6 := (int_to_ptr v_6_tmp) in
          let v_g_ret := (ptr_offset v_granules ((40 * (v_i_241)) + ((32 + (0))))) in
          when v_7_tmp, st == ((load_RData 8 v_g_ret st));
          let v_7 := (int_to_ptr v_7_tmp) in
          when st == ((store_RData 8 v_7 (ptr_to_int v_6) st));
          let v_inc33 := (v_i_241 + (1)) in
          let v_exitcond := (v_inc33 <>? (2)) in
          match (
            let v_cmp235 := false in
            let __continue__ := false in
            if v_exitcond
            then (
              let v_i_241 := v_inc33 in
              let __continue__ := true in
              (Some (__break__, __continue__, v_cmp235, v_i_241, st)))
            else (
              let v_cmp235 := false in
              let __break__ := true in
              (Some (__break__, __continue__, v_cmp235, v_i_241, st)))
          ) with
          | (Some (__break__, __continue__, v_cmp235, v_i_241, st)) =>
            if __break__
            then (Some (__break__, v_granules, v_i_241, st))
            else (
              if __continue__
              then (Some (__break__, v_granules, v_i_241, st))
              else (Some (__break__, v_granules, v_i_241, st)))
          | None => None
          end)
      | None => None
      end
    end.

  Fixpoint find_lock_granules_loop0 (_N_: nat) (__return__: bool) (__retval__: bool) (__break__: bool) (v_granules: Ptr) (v_i_143: Z) (st: RData) : (option (bool * bool * bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
    | (S _N_) =>
      match ((find_lock_granules_loop0 _N_ __return__ __retval__ __break__ v_granules v_i_143 st)) with
      | (Some (__return__, __retval__, __break__, v_granules, v_i_143, st)) =>
        rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
        if __break__
        then (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
        else (
          if __return__
          then (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
          else (
            let v_cmp5_not := (v_i_143 =? (0)) in
            match (
              let v_cmp10 := false in
              let v_addr9 := (mkPtr "#" 0) in
              let v_addr := (mkPtr "#" 0) in
              let v_3 := 0 in
              let v_2 := 0 in
              if v_cmp5_not
              then (Some (__break__, v_2, v_3, v_addr, v_addr9, v_cmp10, st))
              else (
                let v_addr := (ptr_offset v_granules ((40 * (1)) + ((8 + (0))))) in
                when v_2, st == ((load_RData 8 v_addr st));
                let v_addr9 := (ptr_offset v_granules ((40 * (0)) + ((8 + (0))))) in
                when v_3, st == ((load_RData 8 v_addr9 st));
                let v_cmp10 := (v_2 =? (v_3)) in
                when __break__, st == (
                    if v_cmp10
                    then (
                      let __break__ := true in
                      (Some (__break__, st)))
                    else (Some (__break__, st)));
                if __break__
                then (Some (__break__, v_2, v_3, v_addr, v_addr9, v_cmp10, st))
                else (Some (__break__, v_2, v_3, v_addr, v_addr9, v_cmp10, st)))
            ) with
            | (Some (__break__, v_2, v_3, v_addr, v_addr9, v_cmp10, st)) =>
              if __break__
              then (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
              else (
                let v_addr13 := (ptr_offset v_granules ((40 * (v_i_143)) + ((8 + (0))))) in
                when v_4, st == ((load_RData 8 v_addr13 st));
                let v_state := (ptr_offset v_granules ((40 * (v_i_143)) + ((16 + (0))))) in
                when v_5, st == ((load_RData 4 v_state st));
                when v_call, st == ((find_lock_granule_spec v_4 v_5 st));
                let v_g := (ptr_offset v_granules ((40 * (v_i_143)) + ((24 + (0))))) in
                when st == ((store_RData 8 v_g (ptr_to_int v_call) st));
                let v_cmp18 := (ptr_eqb v_call (mkPtr "null" 0)) in
                match (
                  let v_inc33 := 0 in
                  let v_inc23 := 0 in
                  let v_i_241 := 0 in
                  let v_g_ret := (mkPtr "#" 0) in
                  let v_g30 := (mkPtr "#" 0) in
                  let v_exitcond := false in
                  let v_cmp235 := false in
                  let v_cmp2 := false in
                  let v_9 := false in
                  let v_7 := (mkPtr "#" 0) in
                  let v_6 := (mkPtr "#" 0) in
                  let __continue__ := false in
                  if v_cmp18
                  then (
                    let __break__ := true in
                    (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc23, v_inc33, st)))
                  else (
                    let v_inc23 := (v_i_143 + (1)) in
                    let v_cmp2 := (v_inc23 <? (2)) in
                    match (
                      let v_inc33 := 0 in
                      let v_i_241 := 0 in
                      let v_g_ret := (mkPtr "#" 0) in
                      let v_g30 := (mkPtr "#" 0) in
                      let v_exitcond := false in
                      let v_cmp235 := false in
                      let v_9 := false in
                      let v_7 := (mkPtr "#" 0) in
                      let v_6 := (mkPtr "#" 0) in
                      let __continue__ := false in
                      if v_cmp2
                      then (
                        let v_i_143 := 1 in
                        (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc33, st)))
                      else (
                        let v_i_241 := 0 in
                        rely (((find_lock_granules_loop197_rank v_granules v_i_241) >= (0)));
                        match ((find_lock_granules_loop197 (z_to_nat (find_lock_granules_loop197_rank v_granules v_i_241)) false v_granules v_i_241 st)) with
                        | (Some (__break__, v_granules, v_i_241, st)) =>
                          rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
                          if __break__
                          then (
                            let v_9 := (xorb v_cmp235 true) in
                            let __return__ := true in
                            let __retval__ := v_9 in
                            (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc33, st)))
                          else None
                        | None => None
                        end)
                    ) with
                    | (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc33, st)) =>
                      if __return__
                      then (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc23, v_inc33, st))
                      else (
                        if __break__
                        then (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc23, v_inc33, st))
                        else (
                          if __continue__
                          then (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc23, v_inc33, st))
                          else (
                            let __continue__ := true in
                            (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc23, v_inc33, st)))))
                    | None => None
                    end)
                ) with
                | (Some (__break__, __continue__, __return__, __retval__, v_6, v_7, v_9, v_cmp2, v_cmp235, v_exitcond, v_g30, v_g_ret, v_i_143, v_i_241, v_inc23, v_inc33, st)) =>
                  if __return__
                  then (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
                  else (
                    if __break__
                    then (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
                    else (
                      if __continue__
                      then (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))
                      else (Some (__return__, __retval__, __break__, v_granules, v_i_143, st))))
                | None => None
                end)
            | None => None
            end))
      | None => None
      end
    end.

  Definition find_lock_granules_spec (v_granules: Ptr) (v_n: Z) (st: RData) : (option (bool * RData)) :=
    rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
    match ((find_lock_granules_loop0 (z_to_nat 2) false false false v_granules 0 (lens 1328 st))) with
    | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
      rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
      if __return__
      then (Some (__retval__, st_3))
      else (
        if (v_i_144 >? (0))
        then (
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
          rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
          when cid == (
              ((((st_3.(share)).(granules)) @
                (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (false, (lens 1331 st_3))))
        else (Some (false, st_3)))
    | None => None
    end.

End GranuleInfo_Spec.

#[global] Hint Unfold find_lock_granules_loop197_rank: spec.
#[global] Hint Unfold find_lock_granules_loop0_rank: spec.
#[global] Hint Unfold get_cached_llt_info_spec: spec.
#[global] Hint Unfold slot_to_va_spec: spec.
#[global] Hint Unfold granule_unlock_transition_spec: spec.
Opaque find_lock_granules_loop197.
Opaque find_lock_granules_loop0.
#[global] Hint Unfold find_lock_granules_spec: spec.
