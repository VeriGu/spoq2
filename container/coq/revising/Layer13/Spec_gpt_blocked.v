Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_read_feature_register_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_s_smc_result")) /\ (((v_1.(poffset)) = (0)))));
    if (v_0 =? (0))
    then (
      when ret, st' == ((max_pa_size_spec' st));
      (Some (lens 126 st)))
    else (Some (lens 187 st)).

  Definition smc_realm_activate_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      match (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely ((((((((lens 4 st).(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          if (((((((lens 4 st).(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
          then (Some (0, (lens 81 st)))
          else (Some (5, (lens 82 st))))
        else (Some (4294967553, (lens 11 st)))
      | (Some cid) => None
      end)
    else (
      match (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely ((((((((lens 4 st).(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          if (((((((lens 4 st).(share)).(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_state_s_rd)) =? (0))
          then (Some (0, (lens 84 st)))
          else (Some (5, (lens 85 st))))
        else (Some (4294967553, (lens 11 st)))
      | (Some cid) => None
      end).
    
  Definition smc_granule_delegate_gpt_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 0 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      let v_index := (v_3.(poffset) / 16) in
      (* model gpt flag set *)
      let new_gpt := st_0.(share).[gpt] :< ( st_0.(share).(gpt) # v_index == true ) in
      when v_7, st_1 == Some(0, st_0.[share] :< new_gpt);
      (* when v_7, st_2 == ((set_pas_realm_spec v_0 st_1)); *)
      (* when st_3 == ((clear_tte_ns_spec v_0 st_2)); *)
      when st_2 == Some(lens 0 st_1);
      if (v_7 =? (0))
      then (
        let g := ((st_2.(share).(globals)).(g_granules) @ v_index) in
        let glo := (((st_2.(share)).(globals))) in
        let new_granules := glo.(g_granules) # v_index == (g.[e_state_s_granule] :< (1)) in
        let st_3 := (st_2.[share].[globals].[g_granules] :< new_granules) in
        (* when st_3 == ((granule_set_state_spec v_3 1 st_2)); *)
        (* when st_4 == ((granule_memzero_spec v_3 1 st_3)); *)
        when st_4 == Some(lens 1 st_3);
        (* when st_6 == ((granule_unlock_gpt_spec v_3 st_4)); *)
        when st_6 == Some(lens 2 st_4);
        (Some (0, st_6)))
      else (
        when st_5 == ((granule_unlock_spec v_3 st_2));
        when v_12, st_6 == ((pack_return_code_spec 1 1 st_5));
        (Some (v_12, st_6)))).
 
  Parameter abs_tte: Z.
  Definition rsi_rtt_destroy_gpt_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) \/ ((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - (556198264832)) < (0)))))) /\
        (((v_1 & (4095)) = (0)))));
    if ((v_1 - (MEM1_PHYS)) >=? (0))
    then (
      match (((((((st.(share)).(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        if (((((((st.(share)).(globals)).(g_granules)) @ ((((v_1 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0))
        then (
          when st_2 == Some(lens 4 st);
          rely ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
          rely ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
          if (((((st_2.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
          then (
            rely (((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)) /\ ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (155165824)) < (0)))));
            rely (
              ((((("granules" = ("granules")) /\ ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((6 >= (0)))) /\
                ((6 <= (24)))));
            when ret == ((granule_addr_spec' (mkPtr "granules" ((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
            (* when ret_0 == ((buffer_map_spec' 6 ret false)); *)
            (* rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0))))); *)
            rely ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)) < (512)) /\ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)) >= (0)))));
            when v_19, st_7 == Some(abs_tte, st_2);
            (* ((__tte_read_spec (mkPtr (ret_0.(pbase)) ((ret_0.(poffset)) + ((8 * ((((st_2.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_2)); *)
            if (((v_3 + ((- 1))) <? (3)) && (((v_19 & (3)) =? (3))))
            then (
              when ret_1 == ((s2tte_pa_spec' v_19 (v_3 + ((- 1)))));
              if ((ret_1 - (v_0)) =? (0))
              then (
                rely (
                  (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                    (((v_0 & (4095)) = (0)))));
                if ((v_0 - (MEM1_PHYS)) >=? (0))
                then (
                  match (((((((st_7.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                  | None =>
                    rely (((((((((st_7.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                    rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                    if (((((((((lens 4 st_7).(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                    then (
                      (* when ret_2 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))))); *)
                      (* when ret_3 == ((buffer_map_spec' 7 ret_2 false)); *)
                      (* rely ((((ret_3.(pbase)) = ("granule_data")) /\ (((ret_3.(poffset)) >= (0))))); *)
                      (* when ret_4 == ((s2tte_create_ripas_spec' 1)); *)
                      (Some (0, (lens 207 st_7))))
                    else (Some (4, (lens 209 st_7)))
                  | (Some cid) => None
                  end)
                else (
                  match (((((((st_7.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                  | None =>
                    rely (((((((((st_7.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                    if (((((((((lens 4 st_7).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                    then (
                      (* when ret_2 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))))); *)
                      (* when ret_3 == ((buffer_map_spec' 7 ret_2 false)); *)
                      (* rely ((((ret_3.(pbase)) = ("granule_data")) /\ (((ret_3.(poffset)) >= (0))))); *)
                      (* when ret_4 == ((s2tte_create_ripas_spec' 1)); *)
                      (Some (0, (lens 215 st_7))))
                    else (Some (4, (lens 217 st_7)))
                  | (Some cid) => None
                  end))
              else (
                (* when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))); *)
                (Some (4294967553, (lens 17 st_7)))))
            else (
              (* when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))); *)
              (Some (((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8)))), (lens 17 st_7)))))
          else (
            (* when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))); *)
            (Some (
              ((((((((st_2.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
              (lens 17 st_2)
            ))))
        else (Some (8589935105, (lens 11 st)))
      | (Some cid) => None
      end)
    else (
      match (((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        if (((((((st.(share)).(globals)).(g_granules)) @ ((v_1 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0))
        then (
          (* when st_2 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" (((v_1 + ((- MEM0_PHYS))) >> (12)) * (16))) 0 64 v_2 (v_3 + ((- 1))) (lens 4 st))); *)
          (* rely ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0))); *)
          (* rely ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0))); *)
          when st_2 == Some(lens 4 st);
          if (((((st_2.(stack)).(stack_s_rtt_walk)).(e_last_level)) - ((v_3 + ((- 1))))) =? (0))
          then (
            rely (((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)) /\ ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (155165824)) < (0)))));
            rely (
              ((((("granules" = ("granules")) /\ ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                ((6 >= (0)))) /\
                ((6 <= (24)))));
            (* when ret == ((granule_addr_spec' (mkPtr "granules" ((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE))))); *)
            (* when ret_0 == ((buffer_map_spec' 6 ret false)); *)
            (* rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0))))); *)
            (* rely ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)) < (512)) /\ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)) >= (0))))); *)
            (* when v_19, st_7 == ((__tte_read_spec (mkPtr (ret_0.(pbase)) ((ret_0.(poffset)) + ((8 * ((((st_2.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_2)); *)
            when v_19, st_7 == Some(abs_tte, st_2);
            if (((v_3 + ((- 1))) <? (3)) && (((v_19 & (3)) =? (3))))
            then (
              when ret_1 == ((s2tte_pa_spec' v_19 (v_3 + ((- 1)))));
              if ((ret_1 - (v_0)) =? (0))
              then (
                rely (
                  (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                    (((v_0 & (4095)) = (0)))));
                if ((v_0 - (MEM1_PHYS)) >=? (0))
                then (
                  match (((((((st_7.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
                  | None =>
                    rely (((((((((st_7.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                    rely (((0 = (0)) /\ (((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) >= (0)))));
                    if (((((((((lens 4 st_7).(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                    then (
                      (* when ret_2 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))))); *)
                      (* when ret_3 == ((buffer_map_spec' 7 ret_2 false)); *)
                      (* rely ((((ret_3.(pbase)) = ("granule_data")) /\ (((ret_3.(poffset)) >= (0))))); *)
                      (* when ret_4 == ((s2tte_create_ripas_spec' 1)); *)
                      (Some (0, (lens 223 st_7))))
                    else (Some (4, (lens 225 st_7)))
                  | (Some cid) => None
                  end)
                else (
                  match (((((((st_7.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
                  | None =>
                    rely (((((((((st_7.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0)) = (true)));
                    if (((((((((lens 4 st_7).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0))
                    then (
                      (* when ret_2 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))))); *)
                      (* when ret_3 == ((buffer_map_spec' 7 ret_2 false)); *)
                      (* rely ((((ret_3.(pbase)) = ("granule_data")) /\ (((ret_3.(poffset)) >= (0))))); *)
                      (* when ret_4 == ((s2tte_create_ripas_spec' 1)); *)
                      (Some (0, (lens 231 st_7))))
                    else (Some (4, (lens 233 st_7)))
                  | (Some cid) => None
                  end))
              else (
                (* when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))); *)
                (Some (4294967553, (lens 17 st_7)))))
            else (
              (* when cid == (((((((st_7.(share)).(globals)).(g_granules)) @ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))); *)
              (Some (((((((v_3 + ((- 1))) << (32)) + (8)) >> (24)) & (4294967040)) |' ((((v_3 + ((- 1))) << (32)) + (8)))), (lens 17 st_7)))))
          else (
            (* when cid == (((((((st_2.(share)).(globals)).(g_granules)) @ (((((st_2.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))); *)
            (Some (
              ((((((((st_2.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                ((((((st_2.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
              (lens 17 st_2)
            ))))
        else (Some (8589935105, (lens 11 st)))
      | (Some cid) => None
      end).
 
  Definition rtt_walk_lock_unlock_gpt_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    Some (lens 123 st).
  
  Definition abstracted__tte_read_spec (ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some (abs_tte, st)).
  
  Definition granule_unlock_gpt_spec (v_0: Ptr) (st: RData) : (option RData) :=
    let v_2 := (ptr_offset v_0 ((16 * (0)) + ((0 + (0))))) in
    when st == ((spinlock_release_spec v_2 st));
    let __return__ := true in
    (Some st).
  
  Definition granule_try_lock_gpt_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0.(pbase)) =s ("granules"))
    then (
      match (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_lock)).(e_val))) with
      | None =>
        rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
        if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)) - (v_1)) =? (0))
        then (Some (true, (lens 26 st)))
        else (Some (false, (lens 33 st)))
      | (Some cid) => None
      end)
    else (
      if ((v_0.(pbase)) =s ("vmid_lock"))
      then (
        rely ((((v_0.(poffset)) =? (0)) = (true)));
        None)
      else None).
  
  Definition granule_lock_gpt_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_3, st_0 == ((granule_try_lock_gpt_spec v_0 v_1 st));
    (Some st_0).
  
  Parameter int_to_ptr_abs: Ptr.
  Parameter abs_g: Z.
  Parameter abs_ptr: Ptr.
  Definition rsi_rtt_set_ripas_gpt_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if (v_3 >? (1))
    then (Some (1, (lens 10 st)))
    else (
      if ((v_0 & (1)) =? (0))
      then (
        rely (
          (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
            (((v_0 & (4095)) = (0)))));
        if ((v_0 - (MEM1_PHYS)) >=? (0))
        then (
          match (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
          | None =>
            if (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (5)) =? (0))
            then (
              when st_3 == ((rtt_walk_lock_unlock_gpt_spec (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))) 0 64 v_1 v_2 (lens 26 st)));
              rely ((((st_3.(share)).(granule_data)) = ((((lens 26 st).(share)).(granule_data)))));
              rely ((((((st_3.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_3.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_3.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                when v_34, st_7 == Some(abs_ptr, (lens 34 st_3));
                when v_37, st_8 == ((abstracted__tte_read_spec (mkPtr (v_34.(pbase)) ((v_34.(poffset)) + ((8 * ((((st_3.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_7));
                when v_38, st_10 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 (lens 96 st_8)));
                (Some (0, (lens 10 st_10))))
              else (
                when st_7 == ((granule_unlock_gpt_spec int_to_ptr_abs st_3));
                (Some (
                  ((((((((st_3.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_3.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  st_7
                ))))
            else (Some (4294967553, (lens 33 st)))
          | (Some cid) => None
          end)
        else (
          match (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
          | None =>
            if (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (5)) =? (0))
            then (
              when st_3 == ((rtt_walk_lock_unlock_gpt_spec (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) 0 64 v_1 v_2 (lens 26 st)));
              rely ((((st_3.(share)).(granule_data)) = ((((lens 26 st).(share)).(granule_data)))));
              rely ((((((st_3.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_3.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_3.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                when v_34, st_7 == Some(abs_ptr, (lens 34 st_3));
                when v_37, st_8 == ((abstracted__tte_read_spec (mkPtr (v_34.(pbase)) ((v_34.(poffset)) + ((8 * ((((st_3.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_7));
                when v_38, st_10 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 (lens 97 st_8)));
                (Some (0, (lens 10 st_10))))
              else (
                when st_7 == ((granule_unlock_gpt_spec int_to_ptr_abs st_3));
                (Some (
                  ((((((((st_3.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_3.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  st_7
                ))))
            else (Some (4294967553, (lens 33 st)))
          | (Some cid) => None
          end))
      else (
        rely (
          ((((((v_0 & ((- 2))) - (MEM0_PHYS)) >= (0)) /\ ((((v_0 & ((- 2))) - (4294967296)) < (0)))) \/
            (((((v_0 & ((- 2))) - (MEM1_PHYS)) >= (0)) /\ ((((v_0 & ((- 2))) - (556198264832)) < (0)))))) /\
            ((((v_0 & ((- 2))) & (4095)) = (0)))));
        if (((v_0 & ((- 2))) - (MEM1_PHYS)) >=? (0))
        then (
          match (((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
          | None =>
            if (((((((st.(share)).(globals)).(g_granules)) @ (((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (3)) =? (0))
            then (
              when v_19, st_2 == Some(abs_ptr, (lens 26 st));
              rely (((((v_19.(pbase)) = ("granule_data")) /\ ((((v_19.(poffset)) mod (4096)) = (0)))) /\ (((v_19.(poffset)) >= (0)))));
              rely ((((((((lens 26 st).(share)).(granule_data)) @ ((v_19.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
              when st_4 == Some(lens 38 st_2);
              (* ((granule_lock_spec int_to_ptr_abs 5 (lens 6 st_2))); *)
              when st_5 == ((granule_unlock_gpt_spec (mkPtr "granules" ((((v_0 & ((- 2))) + ((- MEM1_PHYS))) >> (524300)) * (16))) st_4));
              when st_7 == ((rtt_walk_lock_unlock_gpt_spec (mkPtr "stack_s_rtt_walk" 0) int_to_ptr_abs 0 64 v_1 v_2 st_5));
              rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
              rely ((((((st_7.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_7.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_7.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                when v_34, st_11 == Some(abs_ptr, (lens 35 st_7));
                when v_37, st_12 == ((abstracted__tte_read_spec (mkPtr (v_34.(pbase)) ((v_34.(poffset)) + ((8 * ((((st_7.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                when v_38, st_14 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 (lens 98 st_12)));
                (Some (0, (lens 100 st_12))))
              else (
                when st_11 == ((granule_unlock_gpt_spec int_to_ptr_abs st_7));
                (Some (
                  ((((((((st_7.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_7.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  st_11
                ))))
            else (Some (4294967553, (lens 33 st)))
          | (Some cid) => None
          end)
        else (
          match (((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
          | None =>
            if (((((((st.(share)).(globals)).(g_granules)) @ (((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (3)) =? (0))
            then (
              when v_19, st_2 == Some(abs_ptr, (lens 36 st));
              rely (((((v_19.(pbase)) = ("granule_data")) /\ ((((v_19.(poffset)) mod (4096)) = (0)))) /\ (((v_19.(poffset)) >= (0)))));
              rely ((((((((lens 26 st).(share)).(granule_data)) @ ((v_19.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
              when st_4 == Some(lens 39 st_2);
              (* ((granule_lock_spec int_to_ptr_abs 5 (lens 6 st_2))); *)
              when st_5 == ((granule_unlock_gpt_spec (mkPtr "granules" ((((v_0 & ((- 2))) + ((- MEM0_PHYS))) >> (12)) * (16))) st_4));
              when st_7 == ((rtt_walk_lock_unlock_gpt_spec (mkPtr "stack_s_rtt_walk" 0) int_to_ptr_abs 0 64 v_1 v_2 st_5));
              rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
              rely ((((((st_7.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
              rely ((((((st_7.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
              if (((((st_7.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
              then (
                when v_34, st_11 == Some(abs_ptr, (lens 37 st_7));
                when v_37, st_12 == ((abstracted__tte_read_spec (mkPtr (v_34.(pbase)) ((v_34.(poffset)) + ((8 * ((((st_7.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                when v_38, st_14 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 (lens 101 st_12)));
                (Some (0, (lens 103 st_12))))
              else (
                when st_11 == ((granule_unlock_gpt_spec int_to_ptr_abs st_7));
                (Some (
                  ((((((((st_7.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                    ((((((st_7.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                  st_11
                ))))
            else (Some (4294967553, (lens 33 st)))
          | (Some cid) => None
          end))).
        
    

End Layer13_Spec.
#[global] Hint Unfold granule_map_spec: spec.
#[global] Hint Unfold granule_addr_spec: spec.
#[global] Hint Unfold granule_addr_spec': spec.
#[global] Hint Unfold buffer_map_spec: spec.
#[global] Hint Unfold buffer_map_spec': spec.