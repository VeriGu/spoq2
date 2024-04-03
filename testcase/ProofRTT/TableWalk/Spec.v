Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableWalk_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition rtt_walk_lock_unlock_2 (__return__: bool) (v_g_tbls: Ptr) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (init_st: RData) (st: RData) : (option RData) :=
    rely (((v_g_tbls.(pbase)) = ("rtt_walk_lock_unlock_stack")));
    rely (
      ((((((((((((v_wi.(pbase)) = ("smc_rtt_create_stack")) \/ (((v_wi.(pbase)) = ("smc_rtt_fold_stack")))) \/ (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("map_unmap_ns_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_read_entry_stack")))) \/
        (((v_wi.(pbase)) = ("data_create_stack")))) \/
        (((v_wi.(pbase)) = ("smc_data_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_init_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_to_pa_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_get_ripas_stack")))));
    (Some (lens 2620 st)).

  Fixpoint rtt_walk_lock_unlock_loop370 (_N_: nat) (__return__: bool) (__break__: bool) (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
    | (S _N_) =>
      match ((rtt_walk_lock_unlock_loop370 _N_ __return__ __break__ v_g_tbls v_indvars_iv v_level v_map_addr v_wi st)) with
      | (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st)) =>
        if __break__
        then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
        else (
          if __return__
          then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
          else (
            rely (((0 <= (v_indvars_iv)) /\ ((v_indvars_iv < (4)))));
            let v_arrayidx5 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_indvars_iv)) + (0))))) in
            when v_1_tmp, st == ((load_RData 8 v_arrayidx5 st));
            let v_1 := (int_to_ptr v_1_tmp) in
            when v_call7, st == ((__find_lock_next_level_spec v_1 v_map_addr v_indvars_iv st));
            let v_indvars_iv_next := (v_indvars_iv + (1)) in
            rely (((0 <= (v_indvars_iv_next)) /\ ((v_indvars_iv_next < (4)))));
            let v_arrayidx9 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_indvars_iv_next)) + (0))))) in
            when st == ((store_RData 8 v_arrayidx9 (ptr_to_int v_call7) st));
            let v_cmp13 := (ptr_eqb v_call7 (mkPtr "null" 0)) in
            when __return__, st == (
                if v_cmp13
                then (
                  let v_2 := v_indvars_iv in
                  let v_last_level_0 := v_2 in
                  let v_conv20 := v_last_level_0 in
                  let v_last_level21 := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
                  when st == ((store_RData 8 v_last_level21 v_conv20 st));
                  rely (((0 <= (v_conv20)) /\ ((v_conv20 < (4)))));
                  let v_arrayidx23 := (ptr_offset v_g_tbls (((8 * (4)) * (0)) + (((8 * (v_conv20)) + (0))))) in
                  when v_4_tmp, st == ((load_RData 8 v_arrayidx23 st));
                  let v_4 := (int_to_ptr v_4_tmp) in
                  let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
                  when st == ((store_RData 8 v_g_llt (ptr_to_int v_4) st));
                  when v_call25, st == ((s2_addr_to_idx_spec v_map_addr v_conv20 st));
                  let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
                  when st == ((store_RData 8 v_index v_call25 st));
                  let __return__ := true in
                  (Some (__return__, st)))
                else (Some (__return__, st)));
            if __return__
            then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
            else (
              when v_3_tmp, st == ((load_RData 8 v_arrayidx5 st));
              let v_3 := (int_to_ptr v_3_tmp) in
              when st == ((granule_unlock_spec v_3 st));
              let v_cmp2 := (v_indvars_iv_next <? (v_level)) in
              match (
                let __continue__ := false in
                if v_cmp2
                then (
                  let v_indvars_iv := v_indvars_iv_next in
                  let __continue__ := true in
                  (Some (__break__, __continue__, v_indvars_iv, st)))
                else (
                  let __break__ := true in
                  (Some (__break__, __continue__, v_indvars_iv, st)))
              ) with
              | (Some (__break__, __continue__, v_indvars_iv, st)) =>
                if __break__
                then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
                else (
                  if __continue__
                  then (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
                  else (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st)))
              | None => None
              end)))
      | None => None
      end
    end.

  Definition rtt_walk_lock_unlock_1 (v_g_tbls: Ptr) (v_g_root_addr_0: Ptr) (v_start_level: Z) (v_ipa_bits: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (init_st: RData) (st: RData) : (option RData) :=
    rely (((v_g_tbls.(pbase)) = ("rtt_walk_lock_unlock_stack")));
    rely (((v_g_root_addr_0.(pbase)) = ("granules")));
    rely (
      ((((((((((((v_wi.(pbase)) = ("smc_rtt_create_stack")) \/ (((v_wi.(pbase)) = ("smc_rtt_fold_stack")))) \/ (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("map_unmap_ns_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_read_entry_stack")))) \/
        (((v_wi.(pbase)) = ("data_create_stack")))) \/
        (((v_wi.(pbase)) = ("smc_data_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_init_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_to_pa_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_get_ripas_stack")))));
    rely ((((0 - (v_start_level)) <= (0)) /\ ((v_start_level < (4)))));
    if ((v_start_level - (v_level)) <? (0))
    then (
      match ((rtt_walk_lock_unlock_loop370 (z_to_nat v_level) false false v_g_tbls v_start_level v_level v_map_addr v_wi (lens 6249 st))) with
      | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_1)) => (Some (lens 2620 st_1))
      | None => None
      end)
    else (Some (lens 6276 st)).

  Definition rtt_walk_lock_unlock_spec (v_g_root: Ptr) (v_start_level: Z) (v_ipa_bits: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (st: RData) : (option RData) :=
    rely (
      ((((((((((((v_wi.(pbase)) = ("smc_rtt_create_stack")) \/ (((v_wi.(pbase)) = ("smc_rtt_fold_stack")))) \/ (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("map_unmap_ns_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_read_entry_stack")))) \/
        (((v_wi.(pbase)) = ("data_create_stack")))) \/
        (((v_wi.(pbase)) = ("smc_data_destroy_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_init_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_to_pa_stack")))) \/
        (((v_wi.(pbase)) = ("realm_ipa_get_ripas_stack")))));
    rely (((v_g_root.(pbase)) = ("granules")));
    when st_2 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "rtt_walk_lock_unlock_stack" 0) 0 32 false st));
    if ((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((((3 - (v_start_level)) * (9)) + (12)))) >? (511))
    then (
      rely (
        (((v_g_root.(pbase)) = ("granules")) /\
          (((((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((((3 - (v_start_level)) * (9)) + (12)))) >> (9)) & (4294967295)))))) mod
            (ST_GRANULE_SIZE)) =
            (0)))));
      when sh == (((st_2.(repl)) ((st_2.(oracle)) (st_2.(log))) (st_2.(share))));
      match (
        ((((st_2.(share)).(granules)) @
          (((v_g_root.(poffset)) + ((16 * ((((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_map_addr)) >> ((((3 - (v_start_level)) * (9)) + (12)))) >> (9)) & (4294967295)))))) /
            (ST_GRANULE_SIZE))).(e_lock))
      ) with
      | None =>
        rely ((((0 - (v_start_level)) <= (0)) /\ ((v_start_level < (4)))));
        if ((v_start_level - (v_level)) <? (0))
        then (
          match ((rtt_walk_lock_unlock_loop370 (z_to_nat v_level) false false (mkPtr "rtt_walk_lock_unlock_stack" 0) v_start_level v_level v_map_addr v_wi (lens 6326 st_2))) with
          | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_1, v_map_addr_1, v_wi_1, st_1)) => (Some (lens 2620 st_1))
          | None => None
          end)
        else (Some (lens 6327 st_2))
      | (Some cid) => None
      end)
    else (
      rely ((((0 - (v_start_level)) <= (0)) /\ ((v_start_level < (4)))));
      if ((v_start_level - (v_level)) <? (0))
      then (
        match ((rtt_walk_lock_unlock_loop370 (z_to_nat v_level) false false (mkPtr "rtt_walk_lock_unlock_stack" 0) v_start_level v_level v_map_addr v_wi (lens 6249 st_2))) with
        | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_1, v_map_addr_1, v_wi_1, st_1)) => (Some (lens 2620 st_1))
        | None => None
        end)
      else (Some (lens 6276 st_2))).

  Definition rtt_walk_lock_unlock_loop370_rank (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) : Z :=
    v_level.

End TableWalk_Spec.

#[global] Hint Unfold rtt_walk_lock_unlock_2: spec.
Opaque rtt_walk_lock_unlock_loop370.
#[global] Hint Unfold rtt_walk_lock_unlock_1: spec.
Opaque rtt_walk_lock_unlock_spec.
#[global] Hint Unfold rtt_walk_lock_unlock_loop370_rank: spec.
