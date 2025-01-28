Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_rtt_walk_lock_unlock_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint rtt_walk_lock_unlock_loop467_low (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_4, v_5, v_7, v_indvars_iv, st))
    | (S _N__0) =>
      match ((rtt_walk_lock_unlock_loop467_low _N__0 __return__ __break__ v_0 v_4 v_5 v_7 v_indvars_iv st)) with
      | (Some (__return___0, __break___0, v_1, v_9, v_6, v_8, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_1, v_9, v_6, v_8, v_indvars_iv_0, st_0))
        else (
          if __return___0
          then (Some (true, false, v_1, v_9, v_6, v_8, v_indvars_iv_0, st_0))
          else (
            rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (4)))));
            when v_23_tmp, st_1 == ((load_RData 8 (ptr_offset v_8 (8 * (v_indvars_iv_0))) st_0));
            when v_24, st_2 == ((__find_lock_next_level_spec (int_to_ptr v_23_tmp) v_9 v_indvars_iv_0 st_1));
            rely ((((0 - ((v_indvars_iv_0 + (1)))) <= (0)) /\ (((v_indvars_iv_0 + (1)) < (4)))));
            when st_3 == ((store_RData 8 (ptr_offset v_8 (8 * ((v_indvars_iv_0 + (1))))) (ptr_to_int v_24) st_2));
            if (ptr_eqb v_24 (mkPtr "null" 0))
            then (
              when st_4 == ((store_RData 8 (ptr_offset v_1 16) v_indvars_iv_0 st_3));
              when v_37_tmp, st_5 == ((load_RData 8 (ptr_offset v_8 (8 * (v_indvars_iv_0))) st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_1 0) v_37_tmp st_5));
              when v_39, st_7 == ((s2_addr_to_idx_spec v_9 v_indvars_iv_0 st_6));
              when st_8 == ((store_RData 8 (ptr_offset v_1 8) v_39 st_7));
              (Some (true, false, v_1, v_9, v_6, v_8, v_indvars_iv_0, st_8)))
            else (
              when v_29_tmp, st_5 == ((load_RData 8 (ptr_offset v_8 (8 * (v_indvars_iv_0))) st_3));
              when st_6 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_5));
              if (((v_indvars_iv_0 + (1)) - (v_6)) <? (0))
              then (Some (false, false, v_1, v_9, v_6, v_8, (v_indvars_iv_0 + (1)), st_6))
              else (Some (false, true, v_1, v_9, v_6, v_8, v_indvars_iv_0, st_6)))))
      | None => None
      end
    end.

  Definition rtt_walk_lock_unlock_spec_low (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
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
          (rtt_walk_lock_unlock_loop467_low
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
          (rtt_walk_lock_unlock_loop467_low
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

End Layer6_rtt_walk_lock_unlock_LowSpec.

#[global] Hint Unfold rtt_walk_lock_unlock_loop467_low: spec.
#[global] Hint Unfold rtt_walk_lock_unlock_spec_low: spec.
