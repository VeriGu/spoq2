Definition table_is_destroyed_block_spec (v_table: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((v_table.(pbase)) = ("slot_rtt2")) /\ ((("s2tte_is_destroyed" = ("s2tte_is_unassigned")) \/ (("s2tte_is_destroyed" = ("s2tte_is_destroyed")))))));
  when ret == ((__tte_read_spec' v_table st));
  if (s2tte_has_hipas_spec' ret 8 st)
  then (
    match ((__table_is_uniform_block_loop777 (z_to_nat 511) true 1 false 0 (mkPtr "null" 0) v_table (mkPtr "s2tte_is_destroyed" 0) st)) with
    | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_3)) => (Some (v_retval_1, st_3))
    | None => None
    end)
  else (Some (false, st)).

Definition table_is_unassigned_block_spec (v_table: Ptr) (v_ripas: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((v_table.(pbase)) = ("slot_rtt2")) /\ ((("s2tte_is_unassigned" = ("s2tte_is_unassigned")) \/ (("s2tte_is_unassigned" = ("s2tte_is_destroyed")))))));
  when ret == ((__tte_read_spec' v_table st));
  if (s2tte_has_hipas_spec' ret 0 st)
  then (
    if (((v_ripas.(pbase)) =s ("null")) && (((v_ripas.(poffset)) =? (0))))
    then (
      match ((__table_is_uniform_block_loop777 (z_to_nat 511) ((v_ripas.(pbase)) =s ("null")) 1 false 0 v_ripas v_table (mkPtr "s2tte_is_unassigned" 0) st)) with
      | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_3)) => (Some (v_retval_1, st_3))
      | None => None
      end)
    else (
      match (
        (__table_is_uniform_block_loop777
          (z_to_nat 511) 
          (((v_ripas.(pbase)) =s ("null")) && (((v_ripas.(poffset)) =? (0)))) 
          1 
          false 
          (s2tte_get_ripas_spec' ret st) 
          v_ripas 
          v_table 
          (mkPtr "s2tte_is_unassigned" 0) 
          st)
      ) with
      | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_1, v_s2tte_is_x_0, st_4)) => (Some (v_retval_1, st_4))
      | None => None
      end))
  else (Some (false, st)).

Definition table_maps_assigned_block_spec (v_table: Ptr) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    (((v_table.(pbase)) = ("slot_rtt2")) /\
      (((("s2tte_is_assigned" = ("s2tte_is_assigned")) \/ (("s2tte_is_assigned" = ("s2tte_is_valid")))) \/ (("s2tte_is_assigned" = ("s2tte_is_valid_ns")))))));
  when ret == ((__tte_read_spec' v_table st));
  if (s2tte_has_hipas_spec' ret 4 st)
  then (
    if (
      ((((((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) & (281474976710655)) &
        (((- 1) << ((((- 38654705616) + ((38654705655 * (v_level)))) & (4294967295)))))) -
        (((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
        (0)))
    then (
      match (
        (__table_maps_block_loop840
          (z_to_nat 511) 
          (1 << ((39 + (((- 9) * (v_level)))))) 
          ((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) 
          1 
          v_level 
          false 
          v_table 
          (mkPtr "s2tte_is_assigned" 0) 
          st)
      ) with
      | (Some (v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
      | None => None
      end)
    else (Some (false, st)))
  else (Some (false, st)).

Definition table_maps_valid_block_spec (v_table: Ptr) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    (((v_table.(pbase)) = ("slot_rtt2")) /\
      (((("s2tte_is_valid" = ("s2tte_is_assigned")) \/ (("s2tte_is_valid" = ("s2tte_is_valid")))) \/ (("s2tte_is_valid" = ("s2tte_is_valid_ns")))))));
  when ret == ((__tte_read_spec' v_table st));
  if (s2tte_check_spec' ret v_level 0 st)
  then (
    if (
      ((((((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) & (281474976710655)) &
        (((- 1) << ((((- 38654705616) + ((38654705655 * (v_level)))) & (4294967295)))))) -
        (((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
        (0)))
    then (
      match (
        (__table_maps_block_loop840
          (z_to_nat 511) 
          (1 << ((39 + (((- 9) * (v_level)))))) 
          ((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) 
          1 
          v_level 
          false 
          v_table 
          (mkPtr "s2tte_is_valid" 0) 
          st)
      ) with
      | (Some (v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
      | None => None
      end)
    else (Some (false, st)))
  else (Some (false, st)).

Definition table_maps_valid_ns_block_spec (v_table: Ptr) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    (((v_table.(pbase)) = ("slot_rtt2")) /\
      (((("s2tte_is_valid_ns" = ("s2tte_is_assigned")) \/ (("s2tte_is_valid_ns" = ("s2tte_is_valid")))) \/ (("s2tte_is_valid_ns" = ("s2tte_is_valid_ns")))))));
  when ret == ((__tte_read_spec' v_table st));
  if (s2tte_check_spec' ret v_level 36028797018963968 st)
  then (
    if (
      ((((((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) & (281474976710655)) &
        (((- 1) << ((((- 38654705616) + ((38654705655 * (v_level)))) & (4294967295)))))) -
        (((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
        (0)))
    then (
      match (
        (__table_maps_block_loop840
          (z_to_nat 511) 
          (1 << ((39 + (((- 9) * (v_level)))))) 
          ((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) 
          1 
          v_level 
          false 
          v_table 
          (mkPtr "s2tte_is_valid_ns" 0) 
          st)
      ) with
      | (Some (v_call_0, v_call3_0, v_i_16, v_level_1, v_retval_2, v_table_1, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
      | None => None
      end)
    else (Some (false, st)))
  else (Some (false, st)).

