Definition free_rec_aux_granules_loop176_rank (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) : Z :=
  0.

Definition free_rec_aux_granules_spec (v_rec_aux: Ptr) (v_cnt: Z) (v_scrub: bool) (st: RData) : (option RData) :=
  (Some st).

Definition gic_cpu_state_init_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
  rely (((v_gicstate.(poffset)) = (584)));
  rely (((v_gicstate.(pbase)) = ("slot_rec")));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)));
  (Some (lens 193 st)).

Definition init_rec_regs_spec (v_rec: Ptr) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely (((v_rec.(pbase)) = ("slot_rec")));
  rely (((v_rec.(poffset)) = (0)));
  rely (((v_rec_params.(pbase)) = ("stack_realm_params")));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)));
  let g_rec := ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)) in
  rely (((v_rd.(pbase)) = ("slot_rd")));
  rely (((v_rd.(poffset)) = (0)));
  (Some (lens 219 st)).

Fixpoint free_rec_aux_granules_loop176 (_N_: nat) (__break__: bool) (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) (st: RData) : (option (bool * Z * Ptr * bool * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((free_rec_aux_granules_loop176 _N__0 __break__ v_indvars_iv v_rec_aux v_scrub v_wide_trip_count st)) with
    | (Some (__break___0, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0)) =>
      if __break___0
      then (Some (true, v_indvars_iv_0, v_rec_aux_0, v_scrub_0, v_wide_trip_count_0, st_0))
      else (
        when v_0_tmp, st_1 == ((load_RData 8 (ptr_offset v_rec_aux_0 ((8 * (v_indvars_iv_0)) + (0))) st_0));
        when st_2 == ((granule_lock_spec (int_to_ptr v_0_tmp) 4 st_1));
        if v_scrub_0
        then (
          when st_3 == ((granule_memzero_spec (int_to_ptr v_0_tmp) (v_indvars_iv_0 + (6)) st_2));
          when st_5 == ((granule_unlock_transition_spec (int_to_ptr v_0_tmp) 1 st_3));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, (v_indvars_iv_0 + (1)), v_rec_aux_0, true, v_wide_trip_count_0, st_5))
          else (Some (true, v_indvars_iv_0, v_rec_aux_0, true, v_wide_trip_count_0, st_5)))
        else (
          when st_4 == ((granule_unlock_transition_spec (int_to_ptr v_0_tmp) 1 st_2));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, (v_indvars_iv_0 + (1)), v_rec_aux_0, false, v_wide_trip_count_0, st_4))
          else (Some (true, v_indvars_iv_0, v_rec_aux_0, false, v_wide_trip_count_0, st_4))))
    | None => None
    end
  end.

