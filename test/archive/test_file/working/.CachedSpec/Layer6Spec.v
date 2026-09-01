Definition rtt_walk_lock_unlock_spec_abs (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option (abs_ret_rtt * RData)) :=
  (Some ((mkabs_ret_rtt 0 v_0 0), st)).

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

Definition s2tt_init_unassigned_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
  (Some st).

Definition s2tt_init_unassigned_loop759_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
  0.

Definition s2tt_init_unassigned_loop759_0_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
  0.

Definition granule_set_state_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
  rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (6)))));
  (Some (st.[share].[globals].[g_granules] :<
    ((((st.(share)).(globals)).(g_granules)) #
      (((v_0.(poffset)) + (4)) / (16)) ==
      (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (4)) / (16))).[e_state_s_granule] :< v_1)))).

Definition pack_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  let (v_2, st_0) := (((v_1 << (32)) + (v_0)), st) in
  let (v_4, st_1) := ((((v_2 >> (24)) & (4294967040)) |' (v_2)), st_0) in
  (Some (v_4, st_1)).

