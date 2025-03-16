Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import Helpers.Spec.
Require Import TableAux.Spec.
Require Import TableWalk.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableWalk_rtt_walk_lock_unlock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint rtt_walk_lock_unlock_loop370_low (_N_: nat) (__return__: bool) (__break__: bool) (v_g_tbls: Ptr) (v_indvars_iv: Z) (v_level: Z) (v_map_addr: Z) (v_wi: Ptr) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_g_tbls, v_indvars_iv, v_level, v_map_addr, v_wi, st))
    | (S _N__0) =>
      match ((rtt_walk_lock_unlock_loop370_low _N__0 __return__ __break__ v_g_tbls v_indvars_iv v_level v_map_addr v_wi st)) with
      | (Some (__return___0, __break___0, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_0))
        else (
          if __return___0
          then (Some (true, false, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_0))
          else (
            rely (((v_wi_0.(poffset)) = (0)));
            rely (((v_wi_0.(pbase)) = ("stack_wi")));
            rely (((v_g_tbls_0.(poffset)) = (0)));
            rely (((v_g_tbls_0.(pbase)) = ("stack_g_tbls")));
            rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (4)))));
            when v_1_tmp, st_1 == ((load_RData 8 (ptr_offset v_g_tbls_0 (8 * (v_indvars_iv_0))) st_0));
            when v_call7, st_2 == ((__find_lock_next_level_spec (int_to_ptr v_1_tmp) v_map_addr_0 v_indvars_iv_0 st_1));
            rely ((((0 - ((v_indvars_iv_0 + (1)))) <= (0)) /\ (((v_indvars_iv_0 + (1)) < (4)))));
            when st_3 == ((store_RData 8 (ptr_offset v_g_tbls_0 (8 * ((v_indvars_iv_0 + (1))))) (ptr_to_int v_call7) st_2));
            if (ptr_eqb v_call7 (mkPtr "null" 0))
            then (
              when st_4 == ((store_RData 8 (ptr_offset v_wi_0 16) v_indvars_iv_0 st_3));
              when v_4_tmp, st_5 == ((load_RData 8 (ptr_offset v_g_tbls_0 (8 * (v_indvars_iv_0))) st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_wi_0 0) v_4_tmp st_5));
              when v_call25, st_7 == ((s2_addr_to_idx_spec v_map_addr_0 v_indvars_iv_0 st_6));
              when st_8 == ((store_RData 8 (ptr_offset v_wi_0 8) v_call25 st_7));
              (Some (true, false, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_8)))
            else (
              when v_3_tmp, st_5 == ((load_RData 8 (ptr_offset v_g_tbls_0 (8 * (v_indvars_iv_0))) st_3));
              when st_6 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_5));
              match (
                if (((v_indvars_iv_0 + (1)) - (v_level_0)) <? (0))
                then (Some (false, true, (v_indvars_iv_0 + (1)), st_6))
                else (Some (true, false, v_indvars_iv_0, st_6))
              ) with
              | (Some (break___1, __continue__, v_indvars_iv_1, st_7)) =>
                if break___1
                then (Some (false, true, v_g_tbls_0, v_indvars_iv_1, v_level_0, v_map_addr_0, v_wi_0, st_7))
                else (Some (false, false, v_g_tbls_0, v_indvars_iv_1, v_level_0, v_map_addr_0, v_wi_0, st_7))
              | None => None
              end)))
      | None => None
      end
    end.

  Definition rtt_walk_lock_unlock_spec_low (v_g_root: Ptr) (v_start_level: Z) (v_ipa_bits: Z) (v_map_addr: Z) (v_level: Z) (v_wi: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rtt_walk_lock_unlock" st));
    rely ((v_start_level < (4)));
    rely ((v_start_level >= (0)));
    rely (((v_wi.(poffset)) = (0)));
    rely (((v_wi.(pbase)) = ("stack_wi")));
    rely (((v_g_root.(pbase)) = ("granules")));
    when v_g_tbls, st_1 == ((alloc_stack "rtt_walk_lock_unlock" 32 8 st_0));
    when st_2 == ((llvm_memset_p0i8_i64_spec v_g_tbls 0 32 false st_1));
    when v_call, st_3 == ((s2_sl_addr_to_idx_spec v_map_addr v_start_level v_ipa_bits st_2));
    if (v_call >? (511))
    then (
      when st_4 == ((granule_lock_spec (ptr_offset v_g_root (16 * (((v_call >> (9)) & (4294967295))))) 6 st_3));
      when st_5 == ((granule_unlock_spec v_g_root st_4));
      when st_7 == ((store_RData 8 (ptr_offset v_g_tbls (8 * (v_start_level))) (ptr_to_int (ptr_offset v_g_root (16 * (((v_call >> (9)) & (4294967295)))))) st_5));
      if ((v_start_level - (v_level)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop370_rank v_g_tbls v_start_level v_level v_map_addr v_wi) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop370_low
            (z_to_nat (rtt_walk_lock_unlock_loop370_rank v_g_tbls v_start_level v_level v_map_addr v_wi))
            false
            false
            v_g_tbls
            v_start_level
            v_level
            v_map_addr
            v_wi
            st_7)
        ) with
        | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_8)) =>
          rely (((v_wi_0.(poffset)) = (0)));
          rely (((v_wi_0.(pbase)) = ("stack_wi")));
          rely (((v_g_tbls_0.(poffset)) = (0)));
          rely (((v_g_tbls_0.(pbase)) = ("stack_g_tbls")));
          if __return___0
          then (
            when st_10 == ((free_stack "rtt_walk_lock_unlock" st_0 st_8));
            (Some st_10))
          else (
            when st_10 == ((store_RData 8 (ptr_offset v_wi_0 16) v_level_0 st_8));
            rely ((((0 - (v_level_0)) <= (0)) /\ ((v_level_0 < (4)))));
            when v_4_tmp, st_11 == ((load_RData 8 (ptr_offset v_g_tbls_0 (8 * (v_level_0))) st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_wi_0 0) v_4_tmp st_11));
            when v_call25, st_13 == ((s2_addr_to_idx_spec v_map_addr_0 v_level_0 st_12));
            when st_14 == ((store_RData 8 (ptr_offset v_wi_0 8) v_call25 st_13));
            when st_15 == ((free_stack "rtt_walk_lock_unlock" st_0 st_14));
            (Some st_15))
        | None => None
        end)
      else (
        when st_9 == ((store_RData 8 (ptr_offset v_wi 16) v_level st_7));
        rely ((((0 - (v_level)) <= (0)) /\ ((v_level < (4)))));
        when v_4_tmp, st_10 == ((load_RData 8 (ptr_offset v_g_tbls (8 * (v_level))) st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_wi 0) v_4_tmp st_10));
        when v_call25, st_12 == ((s2_addr_to_idx_spec v_map_addr v_level st_11));
        when st_13 == ((store_RData 8 (ptr_offset v_wi 8) v_call25 st_12));
        when st_14 == ((free_stack "rtt_walk_lock_unlock" st_0 st_13));
        (Some st_14)))
    else (
      when st_5 == ((store_RData 8 (ptr_offset v_g_tbls (8 * (v_start_level))) (ptr_to_int v_g_root) st_3));
      if ((v_start_level - (v_level)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop370_rank v_g_tbls v_start_level v_level v_map_addr v_wi) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop370_low
            (z_to_nat (rtt_walk_lock_unlock_loop370_rank v_g_tbls v_start_level v_level v_map_addr v_wi))
            false
            false
            v_g_tbls
            v_start_level
            v_level
            v_map_addr
            v_wi
            st_5)
        ) with
        | (Some (__return___0, __break__, v_g_tbls_0, v_indvars_iv_0, v_level_0, v_map_addr_0, v_wi_0, st_6)) =>
          rely (((v_wi_0.(poffset)) = (0)));
          rely (((v_wi_0.(pbase)) = ("stack_wi")));
          rely (((v_g_tbls_0.(poffset)) = (0)));
          rely (((v_g_tbls_0.(pbase)) = ("stack_g_tbls")));
          if __return___0
          then (
            when st_8 == ((free_stack "rtt_walk_lock_unlock" st_0 st_6));
            (Some st_8))
          else (
            when st_8 == ((store_RData 8 (ptr_offset v_wi_0 16) v_level_0 st_6));
            rely ((((0 - (v_level_0)) <= (0)) /\ ((v_level_0 < (4)))));
            when v_4_tmp, st_9 == ((load_RData 8 (ptr_offset v_g_tbls_0 (8 * (v_level_0))) st_8));
            when st_10 == ((store_RData 8 (ptr_offset v_wi_0 0) v_4_tmp st_9));
            when v_call25, st_11 == ((s2_addr_to_idx_spec v_map_addr_0 v_level_0 st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_wi_0 8) v_call25 st_11));
            when st_13 == ((free_stack "rtt_walk_lock_unlock" st_0 st_12));
            (Some st_13))
        | None => None
        end)
      else (
        when st_7 == ((store_RData 8 (ptr_offset v_wi 16) v_level st_5));
        rely ((((0 - (v_level)) <= (0)) /\ ((v_level < (4)))));
        when v_4_tmp, st_8 == ((load_RData 8 (ptr_offset v_g_tbls (8 * (v_level))) st_7));
        when st_9 == ((store_RData 8 (ptr_offset v_wi 0) v_4_tmp st_8));
        when v_call25, st_10 == ((s2_addr_to_idx_spec v_map_addr v_level st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_wi 8) v_call25 st_10));
        when st_12 == ((free_stack "rtt_walk_lock_unlock" st_0 st_11));
        (Some st_12))).

End TableWalk_rtt_walk_lock_unlock_LowSpec.

#[global] Hint Unfold rtt_walk_lock_unlock_loop370_low: spec.
#[global] Hint Unfold rtt_walk_lock_unlock_spec_low: spec.
