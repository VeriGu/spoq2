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
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
        if ((v_s2tte_is_x_0.(pbase)) =s ("s2tte_is_unassigned"))
        then (
          if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (3)) =? (0))
          then (
            if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (60)) =? (0))
            then (
              if v_cmp_not_0
              then (
                if ((v_indvars_iv_0 + (1)) <>? (512))
                then (Some (false, true, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                else (Some (true, true, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
              else (
                if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (64)) =? (0))
                then (
                  if ((0 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
                else (
                  if ((1 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))))
            else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
        else (
          if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (3)) =? (0))
          then (
            if (
              ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (60)) - (8)) =?
                (0)))
            then (
              if v_cmp_not_0
              then (
                if ((v_indvars_iv_0 + (1)) <>? (512))
                then (Some (false, true, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                else (Some (true, true, v_indvars_iv_0, true, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
              else (
                if (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ ((v_table_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0))))) & (64)) =? (0))
                then (
                  if ((0 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
                else (
                  if ((1 - (v_ripas_1)) =? (0))
                  then (
                    if ((v_indvars_iv_0 + (1)) <>? (512))
                    then (Some (false, false, (v_indvars_iv_0 + (1)), v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))
                    else None)
                  else (Some (true, false, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))))
            else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0)))
          else (Some (true, v_cmp_not_0, v_indvars_iv_0, false, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_0))))
    | None => None
    end
  end.

Definition __table_is_uniform_block_spec (v_table: Ptr) (v_s2tte_is_x: Ptr) (v_ripas_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_s2tte_is_x.(poffset)) = (0)));
  rely (((v_table.(pbase)) = ("slot_rtt2")));
  rely ((((v_s2tte_is_x.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_destroyed")))));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  if ((v_s2tte_is_x.(pbase)) =s ("s2tte_is_unassigned"))
  then (
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (0))
    then (
      if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (60)) =? (0))
      then (
        if (((v_ripas_ptr.(pbase)) =s ("null")) && (((v_ripas_ptr.(poffset)) =? (0))))
        then (
          match ((__table_is_uniform_block_loop777 (z_to_nat 511) false true 1 false 0 v_ripas_ptr v_table v_s2tte_is_x st)) with
          | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) =>
            rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_0.(pbase)) = ("slot_rtt2")));
            rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
            (Some (v_retval_1, st_3))
          | None => None
          end)
        else (
          if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (64)) =? (0))
          then (
            match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas_ptr v_table v_s2tte_is_x st)) with
            | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) =>
              rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_0.(pbase)) = ("slot_rtt2")));
              rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
              (Some (v_retval_1, st_4))
            | None => None
            end)
          else (
            match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas_ptr v_table v_s2tte_is_x st)) with
            | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) =>
              rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_0.(pbase)) = ("slot_rtt2")));
              rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
              (Some (v_retval_1, st_4))
            | None => None
            end)))
      else (Some (false, st)))
    else (Some (false, st)))
  else (
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (0))
    then (
      if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (60)) - (8)) =? (0))
      then (
        if (((v_ripas_ptr.(pbase)) =s ("null")) && (((v_ripas_ptr.(poffset)) =? (0))))
        then (
          match ((__table_is_uniform_block_loop777 (z_to_nat 511) false true 1 false 0 v_ripas_ptr v_table v_s2tte_is_x st)) with
          | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) =>
            rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
            rely (((v_s2tte_is_x_0.(poffset)) = (0)));
            rely (((v_table_0.(pbase)) = ("slot_rtt2")));
            rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
            (Some (v_retval_1, st_3))
          | None => None
          end)
        else (
          if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (64)) =? (0))
          then (
            match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas_ptr v_table v_s2tte_is_x st)) with
            | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) =>
              rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_0.(pbase)) = ("slot_rtt2")));
              rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
              (Some (v_retval_1, st_4))
            | None => None
            end)
          else (
            match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas_ptr v_table v_s2tte_is_x st)) with
            | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) =>
              rely (((v_ripas_ptr_0.(pbase)) = ("smc_rtt_fold_stack")));
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_0.(pbase)) = ("slot_rtt2")));
              rely ((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_unassigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_destroyed")))));
              (Some (v_retval_1, st_4))
            | None => None
            end)))
      else (Some (false, st)))
    else (Some (false, st))).
