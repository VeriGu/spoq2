Fixpoint __table_maps_block_loop840 (_N_: nat) (__break__: bool) (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_retval_0: bool) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * bool * Ptr * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
  | (S _N__0) =>
    match ((__table_maps_block_loop840 _N__0 __break__ v_call v_call3 v_i_015 v_level v_retval_0 v_table v_s2tte_is_x st)) with
    | (Some (__break___0, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0)) =>
      if __break___0
      then (Some (true, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0))
      else (
        rely (((v_s2tte_is_x_0.(poffset)) = (0)));
        rely (((v_table_0.(pbase)) = ("slot_rtt22")));
        rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
        when v_call10, st_1 == ((__tte_read_spec (ptr_offset v_table_0 ((8 * (v_i_16)) + (0))) st_0));
        when v_call11, st_2 == ((__table_maps_block_funptr_wrap849 v_s2tte_is_x_0 v_call10 v_level_0 st_1));
        if v_call11
        then (
          when v_call14_0, st_3 == ((s2tte_pa_spec v_call10 v_level_0 st_2));
          if ((v_call14_0 - (((v_i_16 * (v_call_0)) + (v_call3_0)))) =? (0))
          then (
            if ((v_i_16 + (1)) <>? (512))
            then (Some (false, v_call_0, v_call3_0, (v_i_16 + (1)), v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_3))
            else (Some (true, v_call_0, v_call3_0, v_i_16, v_level_0, true, v_table_0, v_s2tte_is_x_0, st_3)))
          else (Some (true, v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_3)))
        else (Some (true, v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_2)))
    | None => None
    end
  end.

Fixpoint __table_is_uniform_block_loop777 (_N_: nat) (__break__: bool) (v_cmp_not: bool) (v_indvars_iv: Z) (v_retval_0: bool) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * bool * Z * bool * Z * Ptr * Ptr * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
  | (S _N__0) =>
    match ((__table_is_uniform_block_loop777 _N__0 __break__ v_cmp_not v_indvars_iv v_retval_0 v_ripas_0 v_ripas_ptr v_table v_s2tte_is_x st)) with
    | (Some (__break___0, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)) =>
      if __break___0
      then (Some (true, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
      else (
        rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
        rely (((v_s2tte_is_x_0.(poffset)) = (0)));
        rely (((v_table_0.(pbase)) = ("slot_rtt2")));
        rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
        when v_call7, st_1 == ((__tte_read_spec (ptr_offset v_table_0 ((8 * (v_indvars_iv_0)) + (0))) st_0));
        when v_call8, st_2 == ((__table_is_uniform_block_funptr_wrap788 v_s2tte_is_x_0 v_call7 st_1));
        if v_call8
        then (
          if v_cmp_not_0
          then (
            if ((v_indvars_iv_0 + (1)) <>? (512))
            then (Some (false, true, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_2))
            else (Some (true, true, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_2)))
          else (
            when v_call12_1, st_3 == ((s2tte_get_ripas_spec v_call7 st_2));
            if ((v_call12_1 - (v_ripas_1)) =? (0))
            then (
              if ((v_indvars_iv_0 + (1)) <>? (512))
              then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3))
              else (
                when st_5 == ((store_RData 4 v_ripas_ptr_0 v_ripas_1 st_3));
                (Some (true, false, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_5))))
            else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3))))
        else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_2)))
    | None => None
    end
  end.

Definition __table_is_uniform_block_spec (v_table: Ptr) (v_s2tte_is_x: Ptr) (v_ripas_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_s2tte_is_x.(poffset)) = (0)));
  rely (((v_table.(pbase)) = ("slot_rtt2")));
  rely ((((v_s2tte_is_x.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_destroyed")))));
  when v_call, st_0 == ((__tte_read_spec v_table st));
  when v_call1, st_1 == ((__table_is_uniform_block_funptr_wrap777 v_s2tte_is_x v_call st_0));
  if v_call1
  then (
    if (ptr_eqb v_ripas_ptr (mkPtr "null" 0))
    then (
      rely (((__table_is_uniform_block_loop777_rank true 1 0 v_ripas_ptr v_table v_s2tte_is_x) >= (0)));
      match (
        (__table_is_uniform_block_loop777
          (z_to_nat (__table_is_uniform_block_loop777_rank true 1 0 v_ripas_ptr v_table v_s2tte_is_x))
          false
          true
          1
          false
          0
          v_ripas_ptr
          v_table
          v_s2tte_is_x
          st_1)
      ) with
      | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) => (Some (v_retval_1, st_3))
      | None => None
      end)
    else (
      when v_call3, st_2 == ((s2tte_get_ripas_spec v_call st_1));
      rely (((__table_is_uniform_block_loop777_rank false 1 v_call3 v_ripas_ptr v_table v_s2tte_is_x) >= (0)));
      match (
        (__table_is_uniform_block_loop777
          (z_to_nat (__table_is_uniform_block_loop777_rank false 1 v_call3 v_ripas_ptr v_table v_s2tte_is_x))
          false
          false
          1
          false
          v_call3
          v_ripas_ptr
          v_table
          v_s2tte_is_x
          st_2)
      ) with
      | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) => (Some (v_retval_1, st_4))
      | None => None
      end))
  else (Some (false, st_1)).

Definition __table_maps_block_spec (v_table: Ptr) (v_level: Z) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_table.(pbase)) = ("slot_rtt2")));
  rely (((v_s2tte_is_x.(poffset)) = (0)));
  rely (((((v_s2tte_is_x.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid_ns")))));
  when v_call, st_0 == ((s2tte_map_size_spec v_level st));
  when v_call1, st_1 == ((__tte_read_spec v_table st_0));
  when v_call2, st_2 == ((__table_maps_block_funptr_wrap835 v_s2tte_is_x v_call1 v_level st_1));
  if v_call2
  then (
    when v_call3, st_3 == ((s2tte_pa_spec v_call1 v_level st_2));
    when v_call4, st_4 == ((addr_is_level_aligned_spec v_call3 (v_level + ((- 1))) st_3));
    if v_call4
    then (
      rely (((__table_maps_block_loop840_rank v_call v_call3 1 v_level v_table v_s2tte_is_x) >= (0)));
      match (
        (__table_maps_block_loop840
          (z_to_nat (__table_maps_block_loop840_rank v_call v_call3 1 v_level v_table v_s2tte_is_x))
          false
          v_call
          v_call3
          1
          v_level
          false
          v_table
          v_s2tte_is_x
          st_4)
      ) with
      | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
      | None => None
      end)
    else (Some (false, st_4)))
  else (Some (false, st_2)).

Definition __table_maps_block_funptr_wrap849 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_assigned"))
  then (s2tte_is_assigned_spec arg0 arg1 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_valid"))
    then (s2tte_is_valid_spec arg0 arg1 st)
    else (
      if ((func_ptr.(pbase)) =s ("s2tte_is_valid_ns"))
      then (s2tte_is_valid_ns_spec arg0 arg1 st)
      else None)).

Definition __table_maps_block_funptr_wrap835 (func_ptr: Ptr) (arg0: Z) (arg1: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_assigned"))
  then (s2tte_is_assigned_spec arg0 arg1 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_valid"))
    then (s2tte_is_valid_spec arg0 arg1 st)
    else (
      if ((func_ptr.(pbase)) =s ("s2tte_is_valid_ns"))
      then (s2tte_is_valid_ns_spec arg0 arg1 st)
      else None)).

Definition __table_is_uniform_block_funptr_wrap777 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_unassigned"))
  then (s2tte_is_unassigned_spec arg0 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_destroyed"))
    then (s2tte_is_destroyed_spec arg0 st)
    else None).

Definition __table_is_uniform_block_loop777_rank (v_cmp_not: bool) (v_indvars_iv: Z) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition __table_maps_block_loop840_rank (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_table: Ptr) (v_s2tte_is_x: Ptr) : Z :=
  (512 - (v_i_015)).

Definition __table_is_uniform_block_funptr_wrap788 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_unassigned"))
  then (s2tte_is_unassigned_spec arg0 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_destroyed"))
    then (s2tte_is_destroyed_spec arg0 st)
    else None).

