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

Definition __table_maps_block_loop840_rank (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_table: Ptr) (v_s2tte_is_x: Ptr) : Z :=
  (512 - (v_i_015)).

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

Definition __table_is_uniform_block_funptr_wrap788 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_unassigned"))
  then (s2tte_is_unassigned_spec arg0 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_destroyed"))
    then (s2tte_is_destroyed_spec arg0 st)
    else None).

Definition __table_is_uniform_block_loop777_rank (v_cmp_not: bool) (v_indvars_iv: Z) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition __table_is_uniform_block_funptr_wrap777 (func_ptr: Ptr) (arg0: Z) (st: RData) : (option (bool * RData)) :=
  if ((func_ptr.(pbase)) =s ("s2tte_is_unassigned"))
  then (s2tte_is_unassigned_spec arg0 st)
  else (
    if ((func_ptr.(pbase)) =s ("s2tte_is_destroyed"))
    then (s2tte_is_destroyed_spec arg0 st)
    else None).

Fixpoint __table_maps_block_loop840 (_N_: nat) (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_retval_0: bool) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (Z * Z * Z * Z * bool * Ptr * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
  | (S _N__0) =>
    match ((__table_maps_block_loop840 _N__0 v_call v_call3 v_i_015 v_level v_retval_0 v_table v_s2tte_is_x st)) with
    | (Some (v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0)) =>
      rely (((v_table_0.(pbase)) = ("slot_rtt22")));
      rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
      when ret == ((__tte_read_spec' (mkPtr "slot_rtt22" ((v_table_0.(poffset)) + ((8 * (v_i_16))))) st_0));
      if ((v_s2tte_is_x_0.(pbase)) =s ("s2tte_is_assigned"))
      then (
        if (s2tte_has_hipas_spec' ret 4 st_0)
        then (
          if ((((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level_0)))) & (4294967295)))))) - (((v_i_16 * (v_call_0)) + (v_call3_0)))) =? (0))
          then (
            if ((v_i_16 + (1)) <>? (512))
            then (Some (v_call_0, v_call3_0, (v_i_16 + (1)), v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0))
            else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, true, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_0)))
        else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_0)))
      else (
        if ((v_s2tte_is_x_0.(pbase)) =s ("s2tte_is_valid"))
        then (
          if (s2tte_check_spec' ret v_level_0 0 st_0)
          then (
            if ((((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level_0)))) & (4294967295)))))) - (((v_i_16 * (v_call_0)) + (v_call3_0)))) =? (0))
            then (
              if ((v_i_16 + (1)) <>? (512))
              then (Some (v_call_0, v_call3_0, (v_i_16 + (1)), v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0))
              else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, true, v_table_0, v_s2tte_is_x_0, st_0)))
            else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_0)))
        else (
          if (s2tte_check_spec' ret v_level_0 36028797018963968 st_0)
          then (
            if ((((ret & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level_0)))) & (4294967295)))))) - (((v_i_16 * (v_call_0)) + (v_call3_0)))) =? (0))
            then (
              if ((v_i_16 + (1)) <>? (512))
              then (Some (v_call_0, v_call3_0, (v_i_16 + (1)), v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0))
              else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, true, v_table_0, v_s2tte_is_x_0, st_0)))
            else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (v_call_0, v_call3_0, v_i_16, v_level_0, false, v_table_0, v_s2tte_is_x_0, st_0))))
    | None => None
    end
  end.

Definition __table_maps_block_spec (v_table: Ptr) (v_level: Z) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    (((v_table.(pbase)) = ("slot_rtt2")) /\
      (((((v_s2tte_is_x.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid_ns")))))));
  when ret == ((__tte_read_spec' v_table st));
  if ((v_s2tte_is_x.(pbase)) =s ("s2tte_is_assigned"))
  then (
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
            v_s2tte_is_x 
            st)
        ) with
        | (Some (v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
        | None => None
        end)
      else (Some (false, st)))
    else (Some (false, st)))
  else (
    if ((v_s2tte_is_x.(pbase)) =s ("s2tte_is_valid"))
    then (
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
              v_s2tte_is_x 
              st)
          ) with
          | (Some (v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
          | None => None
          end)
        else (Some (false, st)))
      else (Some (false, st)))
    else (
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
              v_s2tte_is_x 
              st)
          ) with
          | (Some (v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) => (Some (v_retval_2, st_5))
          | None => None
          end)
        else (Some (false, st)))
      else (Some (false, st)))).

Fixpoint __table_is_uniform_block_loop777 (_N_: nat) (v_cmp_not: bool) (v_indvars_iv: Z) (v_retval_0: bool) (v_ripas_0: Z) (v_ripas_ptr: Ptr) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * Z * bool * Z * Ptr * Ptr * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (v_cmp_not, v_indvars_iv, v_retval_0, v_ripas_0, v_ripas_ptr, v_table, v_s2tte_is_x, st))
  | (S _N__0) =>
    match ((__table_is_uniform_block_loop777 _N__0 v_cmp_not v_indvars_iv v_retval_0 v_ripas_0 v_ripas_ptr v_table v_s2tte_is_x st)) with
    | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)) =>
      rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
      rely (((v_table_0.(pbase)) = ("slot_rtt2")));
      rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
      when ret == ((__tte_read_spec' (mkPtr "slot_rtt2" ((v_table_0.(poffset)) + ((8 * (v_indvars_iv_0))))) st_0));
      if ((v_s2tte_is_x_0.(pbase)) =s ("s2tte_is_destroyed"))
      then (
        if (s2tte_has_hipas_spec' ret 8 st_0)
        then (
          if v_cmp_not_0
          then (
            if ((v_indvars_iv_0 + (1)) <>? (512))
            then (Some (v_cmp_not_0, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
            else (Some (v_cmp_not_0, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
          else (
            if (((s2tte_get_ripas_spec' ret st_0) - (v_ripas_1)) =? (0))
            then (
              if ((v_indvars_iv_0 + (1)) <>? (512))
              then (Some (v_cmp_not_0, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
              else (
                (Some (
                  v_cmp_not_0  ,
                  v_indvars_iv_0  ,
                  true  ,
                  v_ripas_1  ,
                  v_ripas_ptr_0  ,
                  v_table_0  ,
                  v_s2tte_is_x_0  ,
                  (st_0.[stack].[smc_rtt_fold_stack] :< (((st_0.(stack)).(smc_rtt_fold_stack)) # (v_ripas_ptr_0.(poffset)) == v_ripas_1))
                ))))
            else (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))))
        else (Some (v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
      else None
    | None => None
    end
  end.

Definition __table_is_uniform_block_spec (v_table: Ptr) (v_s2tte_is_x: Ptr) (v_ripas_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((v_table.(pbase)) = ("slot_rtt2")) /\ ((((v_s2tte_is_x.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_destroyed")))))));
  when ret == ((__tte_read_spec' v_table st));
  if ((v_s2tte_is_x.(pbase)) =s ("s2tte_is_unassigned"))
  then (
    if (s2tte_has_hipas_spec' ret 0 st)
    then (
      if (((v_ripas_ptr.(pbase)) =s ("null")) && (((v_ripas_ptr.(poffset)) =? (0))))
      then (
        match ((__table_is_uniform_block_loop777 (z_to_nat 511) ((v_ripas_ptr.(pbase)) =s ("null")) 1 false 0 v_ripas_ptr v_table v_s2tte_is_x st)) with
        | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) => (Some (v_retval_1, st_3))
        | None => None
        end)
      else (
        match (
          (__table_is_uniform_block_loop777
            (z_to_nat 511) 
            (((v_ripas_ptr.(pbase)) =s ("null")) && (((v_ripas_ptr.(poffset)) =? (0)))) 
            1 
            false 
            (s2tte_get_ripas_spec' ret st) 
            v_ripas_ptr 
            v_table 
            v_s2tte_is_x 
            st)
        ) with
        | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) => (Some (v_retval_1, st_4))
        | None => None
        end))
    else (Some (false, st)))
  else (
    if (s2tte_has_hipas_spec' ret 8 st)
    then (
      if (((v_ripas_ptr.(pbase)) =s ("null")) && (((v_ripas_ptr.(poffset)) =? (0))))
      then (
        match ((__table_is_uniform_block_loop777 (z_to_nat 511) ((v_ripas_ptr.(pbase)) =s ("null")) 1 false 0 v_ripas_ptr v_table v_s2tte_is_x st)) with
        | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) => (Some (v_retval_1, st_3))
        | None => None
        end)
      else (
        match (
          (__table_is_uniform_block_loop777
            (z_to_nat 511) 
            (((v_ripas_ptr.(pbase)) =s ("null")) && (((v_ripas_ptr.(poffset)) =? (0)))) 
            1 
            false 
            (s2tte_get_ripas_spec' ret st) 
            v_ripas_ptr 
            v_table 
            v_s2tte_is_x 
            st)
        ) with
        | (Some (v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) => (Some (v_retval_1, st_4))
        | None => None
        end))
    else (Some (false, st))).

