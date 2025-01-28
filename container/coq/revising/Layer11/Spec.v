Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Spec.
Require Import Layer10.gic_save_state.LowSpec.
Require Import Layer11.init_common_sysregs.LowSpec.
Require Import Layer11.free_sl_rtts.LowSpec.
(* Require Import Layer12.Spec. *)
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Layer9.Spec.
Require Import Layer9.gic_restore_state.LowSpec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition verify_header_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 0) st));
    if (v_3 =? (4278233685))
    then (
      when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 56) st_0));
      if (v_7 =? (3994130790))
      then (
        when v_11, st_2 == ((load_RData 8 (ptr_offset v_0 16) st_1));
        if (v_11 >? (1))
        then (Some (1, st_2))
        else (
          when v_16_tmp, st_3 == ((load_RData 8 (ptr_offset v_0 24) st_2));
          if (ptr_eqb (int_to_ptr v_16_tmp) (mkPtr "null" 0))
          then (
            when v_24_tmp, st_5 == ((load_RData 8 (ptr_offset v_0 40) st_3));
            if (ptr_eqb (int_to_ptr v_24_tmp) (mkPtr "null" 0))
            then (Some (0, st_5))
            else (
              when v_27_tmp, st_6 == ((load_RData 8 (ptr_offset v_0 48) st_5));
              if (ptr_eqb (int_to_ptr v_24_tmp) (int_to_ptr v_27_tmp))
              then (Some (1, st_6))
              else (Some (0, st_6))))
          else (
            when v_19_tmp, st_4 == ((load_RData 8 (ptr_offset v_0 32) st_3));
            if (ptr_eqb (int_to_ptr v_16_tmp) (int_to_ptr v_19_tmp))
            then (Some (1, st_4))
            else (
              when v_24_tmp, st_6 == ((load_RData 8 (ptr_offset v_0 40) st_4));
              if (ptr_eqb (int_to_ptr v_24_tmp) (mkPtr "null" 0))
              then (Some (0, st_6))
              else (
                when v_27_tmp, st_7 == ((load_RData 8 (ptr_offset v_0 48) st_6));
                if (ptr_eqb (int_to_ptr v_24_tmp) (int_to_ptr v_27_tmp))
                then (Some (1, st_7))
                else (Some (0, st_7)))))))
      else (Some (1, st_1)))
    else (Some (1, st_0)).

  Definition bitmap_clear_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely ((((0 - ((v_1 >> (6)))) <= (0)) /\ (((v_1 >> (6)) < (1024)))));
    when v_8, st_0 == ((load_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) st));
    when st_1 == ((store_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) (v_8 & ((Z.lxor (v_1 & (63)) (- 1)))) st_0));
    (Some st_1).

  Definition is_valid_vintid_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    if (v_0 <? (1020))
    then (Some (true, st))
    else (
      if ((v_0 & (18446744073709550592)) =? (4096))
      then (Some (true, st))
      else (
        when v_11, st_0 == ((load_RData 8 (mkPtr "max_vintid" 0) st));
        if (v_0 >? (8191))
        then (Some (((v_11 - (v_0)) >=? (0)), st_0))
        else (Some (false, st_0)))).

  Definition check_pending_timers_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((iasm_6_spec st));
    when v_3, st_1 == ((iasm_7_spec st_0));
    when v_4, st_2 == ((timer_output_is_asserted_spec v_2 st_1));
    when v_6, st_3 == ((load_RData 8 (ptr_offset v_0 568) st_2));
    when v_7, st_4 == ((timer_output_is_asserted_spec v_6 st_3));
    if (xorb v_4 v_7)
    then (Some (true, st_4))
    else (
      when v_10, st_5 == ((timer_output_is_asserted_spec v_3 st_4));
      when v_12, st_6 == ((load_RData 8 (ptr_offset v_0 552) st_5));
      when v_13, st_7 == ((timer_output_is_asserted_spec v_12 st_6));
      (Some ((xorb v_10 v_13), st_7))).

  Definition report_timer_state_to_ns_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((iasm_6_spec st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 136) v_2 st_0));
    when v_4, st_2 == ((iasm_136_spec st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 144) v_4 st_2));
    when v_6, st_4 == ((iasm_get_cntvoff_el2_spec st_3));
    when v_7, st_5 == ((load_RData 8 (ptr_offset v_0 144) st_4));
    when st_6 == ((store_RData 8 (ptr_offset v_0 144) (v_7 - (v_6)) st_5));
    when v_9, st_7 == ((iasm_7_spec st_6));
    when st_8 == ((store_RData 8 (ptr_offset v_0 152) v_9 st_7));
    when v_11, st_9 == ((iasm_139_spec st_8));
    when st_10 == ((store_RData 8 (ptr_offset v_0 160) v_11 st_9));
    (Some st_10).

  Definition save_realm_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((save_sysreg_state_spec (ptr_offset v_0 288) st));
    when v_3, st_1 == ((iasm_get_elr_el2_spec st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 272) v_3 st_1));
    when v_5, st_3 == ((iasm_get_spsr_el2_spec st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 280) v_5 st_3));
    when st_5 == ((gic_save_state_spec (ptr_offset v_0 584) st_4));
    (Some st_5).

  Definition restore_ns_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((restore_sysreg_state_spec (ptr_offset v_0 0) st));
    when v_4, st_1 == ((load_RData 8 (ptr_offset v_0 248) st_0));
    when st_2 == ((iasm_set_cnthctl_el2_spec v_4 st_1));
    when v_6, st_3 == ((load_RData 8 (ptr_offset v_0 560) st_2));
    when st_4 == ((iasm_145_spec v_6 st_3));
    (Some st_4).

  Definition save_ns_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((save_sysreg_state_spec (ptr_offset v_0 0) st));
    when v_3, st_1 == ((iasm_get_cnthctl_el2_spec st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 248) v_3 st_1));
    when v_5, st_3 == ((iasm_207_spec st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 560) v_5 st_3));
    (Some st_4).

  Definition restore_realm_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 536) st));
    when st_1 == ((iasm_set_cnthctl_el2_spec v_4 st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    when st_3 == ((restore_sysreg_state_spec (ptr_offset v_0 288) st_2));
    when v_6, st_4 == ((load_RData 8 (ptr_offset v_0 272) st_3));
    when st_5 == ((iasm_set_elr_el2_spec v_6 st_4));
    when v_8, st_6 == ((load_RData 8 (ptr_offset v_0 280) st_5));
    when st_7 == ((iasm_set_spsr_el2_spec v_8 st_6));
    when v_10, st_8 == ((load_RData 8 (ptr_offset v_0 808) st_7));
    when st_9 == ((iasm_set_hcr_el2_spec v_10 st_8));
    when st_10 == ((gic_restore_state_spec (ptr_offset v_0 584) st_9));
    (Some st_10).

  Definition reset_last_run_info_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((store_RData 8 (ptr_offset v_0 952) 0 st));
    (Some st_0).

  Definition esr_sign_extend_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (2097152)) <>? (0)), st)).

  Definition esr_sixty_four_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (32768)) <>? (0)), st)).

  (* Fixpoint __table_is_uniform_block_loop904 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_14: bool) (v__068: Z) (v_1: Ptr) (st: RData) : (option (bool * Ptr * bool * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_14, v__068, v_1, st))
    | (S _N__0) =>
      match ((__table_is_uniform_block_loop904 _N__0 __break__ v_0 v_14 v__068 v_1 st)) with
      | (Some (__break___0, v_3, v_15, v__69, v_2, st_0)) =>
        if __break___0
        then (Some (true, v_3, v_15, v__69, v_2, st_0))
        else (
          when v_8, st_1 == ((__tte_read_spec (ptr_offset v_3 (8 * (v__69))) st_0));
          when v_9, st_2 == (( v_2 v_8 st_1));
          if v_9
          then (
            if ((v__69 + (1)) <>? (512))
            then (Some (false, v_3, v_15, (v__69 + (1)), v_2, st_2))
            else (Some (true, v_3, ((v__69 + (1)) <? (512)), v__69, v_2, st_2)))
          else (Some (true, v_3, false, v__69, v_2, st_2)))
      | None => None
      end
    end. *)

  (* only used by RTT_FOLD *)
  Definition __table_is_uniform_block_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (bool * RData)) :=
    None.
    (* rely ((( v_0 0 v_1) >= (0)));
    match ((__table_is_uniform_block_loop904 (z_to_nat ( v_0 0 v_1)) false v_0 false 0 v_1 st)) with
    | (Some (__break__, v_3, v_14, v__69, v_2, st_0)) => (Some ((xorb v_14 true), st_0))
    | None => None
    end. *)

  (* Fixpoint __table_maps_block_loop946 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_10: Z) (v_5: Z) (v__0: bool) (v__02223: Z) (v_2: Ptr) (st: RData) : (option (bool * Ptr * Z * Z * Z * bool * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_1, v_10, v_5, v__0, v__02223, v_2, st))
    | (S _N__0) =>
      match ((__table_maps_block_loop946 _N__0 __break__ v_0 v_1 v_10 v_5 v__0 v__02223 v_2 st)) with
      | (Some (__break___0, v_7, v_3, v_11, v_6, v__1, v__2224, v_4, st_0)) =>
        if __break___0
        then (Some (true, v_7, v_3, v_11, v_6, v__1, v__2224, v_4, st_0))
        else (
          when v_18, st_1 == ((__tte_read_spec (ptr_offset v_7 (8 * (v__2224))) st_0));
          when v_19, st_2 == (( v_4 v_18 v_3 st_1));
          if v_19
          then (
            when v_28, st_3 == ((s2tte_pa_spec v_18 v_3 st_2));
            if ((v_28 - (((v__2224 * (v_6)) + (v_11)))) =? (0))
            then (
              if ((v__2224 + (1)) <>? (512))
              then (Some (false, v_7, v_3, v_11, v_6, v__1, (v__2224 + (1)), v_4, st_3))
              else (Some (true, v_7, v_3, v_11, v_6, true, v__2224, v_4, st_3)))
            else (Some (true, v_7, v_3, v_11, v_6, false, v__2224, v_4, st_3)))
          else (Some (true, v_7, v_3, v_11, v_6, false, v__2224, v_4, st_2)))
      | None => None
      end
    end. *)

  (* only used by RTT_FOLD *)
  Definition __table_maps_block_spec (v_0: Ptr) (v_1: Z) (v_2: Ptr) (st: RData) : (option (bool * RData)) :=
    None.
    (* when v_5, st_0 == ((s2tte_map_size_spec v_1 st));
    when v_6, st_1 == ((__tte_read_spec v_0 st_0));
    when v_7, st_2 == (( v_2 v_6 v_1 st_1));
    if v_7
    then (
      when v_10, st_3 == ((s2tte_pa_spec v_6 v_1 st_2));
      when v_12, st_4 == ((addr_is_level_aligned_spec v_10 (v_1 + ((- 1))) st_3));
      if v_12
      then (
        rely ((( v_0 v_1 v_10 v_5 1 v_2) >= (0)));
        match ((__table_maps_block_loop946 (z_to_nat ( v_0 v_1 v_10 v_5 1 v_2)) false v_0 v_1 v_10 v_5 false 1 v_2 st_4)) with
        | (Some (__break__, v_14, v_3, v_13, v_8, v__2, v__2224, v_9, st_5)) => (Some (v__2, st_5))
        | None => None
        end)
      else (Some (false, st_4)))
    else (Some (false, st_2)). *)

  Definition init_common_sysregs_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 1520) st));
    if (v_4 =? (0))
    then (init_common_sysregs_0_low st_0 v_0 v_1 v_4)
    else (
      when v_6, st_1 == ((realm_vtcr_spec v_1 st_0));
      when st_2 == ((store_RData 8 (ptr_offset v_0 848) v_6 st_1));
      when v_9, st_3 == ((load_RData 4 (ptr_offset v_1 40) st_2));
      when v_13, st_4 == ((load_RData 8 (ptr_offset v_0 840) st_3));
      when st_5 == ((store_RData 8 (ptr_offset v_0 840) ((v_9 << (48)) |' (v_13)) st_4));
      (Some st_5)).

  Definition init_rec_sysregs_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((store_RData 8 (ptr_offset v_0 320) 64 st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 360) 12912760 st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 504) 4096 st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 800) (v_1 |' (2147483648)) st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 536) 3072 st_3));
    (Some st_4).

  Definition status_ptr_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((int_to_ptr (0 - (v_0))), st)).

  Definition validate_data_create_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((get_rd_state_locked_spec v_1 st));
    if (v_3 =? (0))
    then (
      when v_7, st_1 == ((validate_data_create_unknown_spec v_0 v_1 st_0));
      (Some (v_7, st_1)))
    else (
      when v_5, st_1 == ((make_return_code_spec 5 0 st_0));
      (Some (v_5, st_1))).

  Definition s2tte_create_valid_spec' (v_0: Z) (v_1: Z) : (option Z) :=
    if (v_1 =? (3))
    then (Some (v_0 |' (2047)))
    else (Some (v_0 |' (2045))).

  Definition s2tte_create_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_create_valid_spec' v_0 v_1));
    (Some (ret, st)).
  (* Definition s2tte_create_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (v_1 =? (3))
    then (Some ((v_0 |' (2047)), st))
    else (Some ((v_0 |' (2045)), st)). *)

  Definition s2tte_is_valid_ns_spec' (v_0: Z) (v_1: Z) : (option bool) :=
    if ((v_0 & (36028797018963968)) =? (0))
    then (Some false)
    else (
      if ((v_1 =? (3)) && (((v_0 & (3)) =? (3))))
      then (Some true)
      else (
        if ((v_1 <>? (3)) && (((v_0 & (3)) =? (1))))
        then (Some true)
        else (Some false))).

  Definition s2tte_is_valid_ns_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((s2tte_is_valid_ns_spec' v_0 v_1));
    (Some (ret, st)).
  (* Definition s2tte_is_valid_ns_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0 & (36028797018963968)) =? (0))
    then (Some (false, st))
    else (
      if ((v_1 =? (3)) && (((v_0 & (3)) =? (3))))
      then (Some (true, st))
      else (
        if ((v_1 <>? (3)) && (((v_0 & (3)) =? (1))))
        then (Some (true, st))
        else (Some (false, st)))). *)

  Definition s2tte_create_valid_ns_spec' (v_0: Z) (v_1: Z) : (option Z) :=
    if (v_1 =? (3))
    then (Some (v_0 |' (54043195528446979)))
    else (Some (v_0 |' (54043195528446977))).

  Definition s2tte_create_valid_ns_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_create_valid_ns_spec' v_0 v_1));
    (Some (ret, st)).
  (* Definition s2tte_create_valid_ns_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (v_1 =? (3))
    then (Some ((v_0 |' (54043195528446979)), st))
    else (Some ((v_0 |' (54043195528446977)), st)). *)

  Definition s2tte_is_destroyed_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (8)), st)).

  Definition validate_rtt_map_cmds_spec' (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((((v_2.(poffset)) mod (4096)) = (0)))));
    if (((- 2) + (v_1)) <? (0))
    then (Some (4294967297, st))
    else (
      when ret, st' == ((validate_map_addr_spec' v_0 v_1 v_2 st));
      (Some (ret, st))).

  Definition validate_rtt_map_cmds_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((validate_rtt_map_cmds_spec' v_0 v_1 v_2 st));
    (Some (ret, st)).        
  (* Definition validate_rtt_map_cmds_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    if (((- 2) + (v_1)) <? (0))
    then (
      when v_7, st_0 == ((make_return_code_spec 1 1 st));
      (Some (v_7, st_0)))
    else (
      when v_9, st_0 == ((validate_map_addr_spec v_0 v_1 v_2 st));
      (Some (v_9, st_0))). *)
  Definition addr_block_intersects_par_spec' (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    if (v_1 =? (18446603885974913024))
    then (Some (false, st))
    else (
      (Some (
        (((((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_rd)).(e_par_size_s_rd)) +
          ((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_rd)).(e_par_base_s_rd)))) -
          (v_1)) >?
          (0)) &&
          (((((1 << ((39 + (((- 9) * (v_2)))))) + (v_1)) - ((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_rd)).(e_par_base_s_rd)))) >? (0))))  ,
        st
      ))).

  Definition addr_block_intersects_par_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    when ret, st' == ((addr_block_intersects_par_spec' v_0 v_1 v_2 st));
    (Some (ret, st)).
  (* Definition addr_block_intersects_par_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    if (v_1 =? (18446603885974913024))
    then (Some (false, st))
    else (
      when v_8, st_0 == ((load_RData 8 (ptr_offset v_0 48) st));
      when v_10, st_1 == ((load_RData 8 (ptr_offset v_0 56) st_0));
      when v_12, st_2 == ((s2tte_map_size_spec v_2 st_1));
      when v_13, st_3 == ((ranges_intersect_spec v_8 v_10 v_1 v_12 st_2));
      (Some (v_13, st_3))). *)

  Definition invalidate_page_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((stage2_tlbi_ipa_spec v_0 v_1 4096 st));
    (Some st_0).

  Definition vmid_reserve_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((load_RData 4 (mkPtr "vmid_count" 0) st));
    if ((v_2 - (v_0)) >? (0))
    then (
      when st_1 == ((spinlock_acquire_spec (mkPtr "vmid_lock" 0) st_0));
      when v_5, st_2 == ((bitmap_test_and_set_spec (ptr_offset (mkPtr "vmids" 0) 0) v_0 st_1));
      when st_3 == ((spinlock_release_spec (mkPtr "vmid_lock" 0) st_2));
      (Some (true, st_3)))
    else (Some (false, st_0)).

  Definition requested_ipa_bits_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 32) st));
    (Some ((v_3 & (255)), st_0)).

  Definition s2_num_root_rtts_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (((48 + (((- 9) * (v_1)))) - (v_0)) <? (0))
    then (Some ((1 << ((v_0 - ((48 + (((- 9) * (v_1)))))))), st))
    else (Some (1, st)).

  Definition validate_rmm_feature_register_value_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if (v_0 =? (0))
    then (
      when v_4, st_0 == ((validate_rmm_feature_register_0_value_spec v_1 st));
      (Some (v_4, st_0)))
    else (Some (false, st)).

  Definition validate_ipa_bits_and_sl_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (((- 32) + (v_0)) <? (0))
    then (
      when v_6, st_0 == ((make_return_code_spec 2 4 st));
      (Some (v_6, st_0)))
    else (
      if (v_1 >? (3))
      then (
        when v_10, st_0 == ((make_return_code_spec 2 5 st));
        (Some (v_10, st_0)))
      else (
        if (v_1 =? (0))
        then (
          when v_14, st_0 == ((max_pa_size_spec st));
          if (v_14 <? (44))
          then (
            when v_17, st_1 == ((make_return_code_spec 2 5 st_0));
            (Some (v_17, st_1)))
          else (
            when v_20, st_2 == ((s2_inconsistent_sl_spec v_0 v_1 st_0));
            if v_20
            then (
              when v_22, st_3 == ((make_return_code_spec 2 5 st_2));
              (Some (v_22, st_3)))
            else (
              when v_24, st_3 == ((make_return_code_spec 0 0 st_2));
              (Some (v_24, st_3)))))
        else (
          when v_20, st_1 == ((s2_inconsistent_sl_spec v_0 v_1 st));
          if v_20
          then (
            when v_22, st_2 == ((make_return_code_spec 2 5 st_1));
            (Some (v_22, st_2)))
          else (
            when v_24, st_2 == ((make_return_code_spec 0 0 st_1));
            (Some (v_24, st_2)))))).

  Fixpoint free_sl_rtts_loop194 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_2: bool) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * bool * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_2, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((free_sl_rtts_loop194 _N__0 __break__ v_0 v_2 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_1, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          when st_1 == ((granule_lock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 5 st_0));
          if v_3
          then (
            when st_2 == ((granule_memzero_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 6 st_1));
            when st_4 == ((granule_unlock_transition_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 1 st_2));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, v_1, true, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_4))
            else (Some (true, v_1, true, v_indvars_iv_0, v_wide_trip_count_0, st_4)))
          else (
            when st_3 == ((granule_unlock_transition_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 1 st_1));
            if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
            then (Some (false, v_1, false, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_3))
            else (Some (true, v_1, false, v_indvars_iv_0, v_wide_trip_count_0, st_3))))
      | None => None
      end
    end.

  Definition free_sl_rtts_spec (v_0: Ptr) (v_1: Z) (v_2: bool) (st: RData) : (option RData) :=
    if ((0 - (v_1)) <? (0))
    then (
      rely (((free_sl_rtts_loop194_rank v_0 v_2 0 v_1) >= (0)));
      match ((free_sl_rtts_loop194 (z_to_nat (free_sl_rtts_loop194_rank v_0 v_2 0 v_1)) false v_0 v_2 0 v_1 st)) with
      | (Some (__break__, v_5, v_3, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
      | None => None
      end)
    else (Some st).

End Layer11_Spec.

#[global] Hint Unfold verify_header_spec: spec.
#[global] Hint Unfold bitmap_clear_spec: spec.
#[global] Hint Unfold is_valid_vintid_spec: spec.
#[global] Hint Unfold check_pending_timers_spec: spec.
#[global] Hint Unfold report_timer_state_to_ns_spec: spec.
#[global] Hint Unfold save_realm_state_spec: spec.
#[global] Hint Unfold restore_ns_state_spec: spec.
#[global] Hint Unfold save_ns_state_spec: spec.
#[global] Hint Unfold restore_realm_state_spec: spec.
#[global] Hint Unfold reset_last_run_info_spec: spec.
#[global] Hint Unfold esr_sign_extend_spec: spec.
#[global] Hint Unfold esr_sixty_four_spec: spec.
(* #[global] Hint Unfold __table_is_uniform_block_loop904: spec. *)
(* #[global] Hint Unfold __table_is_uniform_block_spec: spec. *)
(* #[global] Hint Unfold __table_maps_block_loop946: spec. *)
(* #[global] Hint Unfold __table_maps_block_spec: spec. *)
#[global] Hint Unfold init_common_sysregs_spec: spec.
#[global] Hint Unfold init_rec_sysregs_spec: spec.
#[global] Hint Unfold status_ptr_spec: spec.
#[global] Hint Unfold validate_data_create_spec: spec.
#[global] Hint Unfold s2tte_create_valid_spec: spec.
#[global] Hint Unfold s2tte_is_valid_ns_spec: spec.
#[global] Hint Unfold s2tte_create_valid_ns_spec: spec.
#[global] Hint Unfold s2tte_is_destroyed_spec: spec.
#[global] Hint Unfold validate_rtt_map_cmds_spec: spec.
#[global] Hint Unfold addr_block_intersects_par_spec: spec.
#[global] Hint Unfold invalidate_page_spec: spec.
#[global] Hint Unfold vmid_reserve_spec: spec.
#[global] Hint Unfold requested_ipa_bits_spec: spec.
#[global] Hint Unfold s2_num_root_rtts_spec: spec.
#[global] Hint Unfold validate_rmm_feature_register_value_spec: spec.
#[global] Hint Unfold validate_ipa_bits_and_sl_spec: spec.
#[global] Hint Unfold free_sl_rtts_loop194: spec.
#[global] Hint Unfold free_sl_rtts_spec: spec.
