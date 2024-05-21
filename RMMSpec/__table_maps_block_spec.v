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

  Fixpoint __table_maps_block_loop840 (_N_: nat) (__break__: bool) (v_call: Z) (v_call3: Z) (v_i_015: Z) (v_level: Z) (v_retval_0: bool) (v_table: Ptr) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * bool * Ptr * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_call, v_call3, v_i_015, v_level, v_retval_0, v_table, v_s2tte_is_x, st))
    | (S _N__0) =>
      match ((__table_maps_block_loop840 _N__0 __break__ v_call v_call3 v_i_015 v_level v_retval_0 v_table v_s2tte_is_x st)) with
      | (Some (__break___0, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0)) =>
        rely ((__break___0 = (true)));
        (Some (true, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_1, v_table_0, v_s2tte_is_x_0, st_0))
      | None => None
      end
    end.

  Definition __table_maps_block_spec (v_table: Ptr) (v_level: Z) (v_s2tte_is_x: Ptr) (st: RData) : (option (bool * RData)) :=
    rely (((v_table.(pbase)) = ("slot_rtt2")));
    rely (((v_s2tte_is_x.(poffset)) = (0)));
    rely (((((v_s2tte_is_x.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x.(pbase)) = ("s2tte_is_valid_ns")))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    if ((v_s2tte_is_x.(pbase)) =s ("s2tte_is_assigned"))
    then (
      if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (0))
      then (
        if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (60)) - (4)) =? (0))
        then (
          if (
            (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
              (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) &
              (281474976710655)) &
              (((- 1) << ((((- 38654705616) + ((38654705655 * (v_level)))) & (4294967295)))))) -
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
              (0)))
          then (
            match (
              (__table_maps_block_loop840
                (z_to_nat 511)
                false
                (1 << ((39 + (((- 9) * (v_level))))))
                (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295))))))
                1
                v_level
                false
                v_table
                v_s2tte_is_x
                st)
            ) with
            | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) =>
              rely (((v_s2tte_is_x_0.(poffset)) = (0)));
              rely (((v_table_0.(pbase)) = ("slot_rtt22")));
              rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
              (Some (v_retval_2, st_5))
            | None => None
            end)
          else (Some (false, st)))
        else (Some (false, st)))
      else (Some (false, st)))
    else (
      if ((v_s2tte_is_x.(pbase)) =s ("s2tte_is_valid"))
      then (
        if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (36028797018963968)) =? (0))
        then (
          if ((v_level =? (3)) && ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (3))))
          then (
            if (
              (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) &
                (281474976710655)) &
                (((- 1) << ((((- 38654705616) + ((38654705655 * (v_level)))) & (4294967295)))))) -
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
                (0)))
            then (
              match (
                (__table_maps_block_loop840
                  (z_to_nat 511)
                  false
                  (1 << ((39 + (((- 9) * (v_level))))))
                  (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                    (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295))))))
                  1
                  v_level
                  false
                  v_table
                  v_s2tte_is_x
                  st)
              ) with
              | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) =>
                rely (((v_s2tte_is_x_0.(poffset)) = (0)));
                rely (((v_table_0.(pbase)) = ("slot_rtt22")));
                rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
                (Some (v_retval_2, st_5))
              | None => None
              end)
            else (Some (false, st)))
          else (
            if ((v_level =? (2)) && ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (1))))
            then (
              if (
                (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) &
                  (281474976710655)) &
                  (((- 1) << ((((- 38654705616) + ((38654705655 * (v_level)))) & (4294967295)))))) -
                  ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                    (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
                  (0)))
              then (
                rely ((511 >= (0)));
                match (
                  (__table_maps_block_loop840
                    (z_to_nat 511)
                    false
                    (1 << ((39 + (((- 9) * (v_level))))))
                    (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                      (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295))))))
                    1
                    v_level
                    false
                    v_table
                    v_s2tte_is_x
                    st)
                ) with
                | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) =>
                  rely (((v_s2tte_is_x_0.(poffset)) = (0)));
                  rely (((v_table_0.(pbase)) = ("slot_rtt22")));
                  rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
                  (Some (v_retval_2, st_5))
                | None => None
                end)
              else (Some (false, st)))
            else (Some (false, st))))
        else (Some (false, st)))
      else (
        if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (36028797018963968)) - (36028797018963968)) =? (0))
        then (
          if ((v_level =? (3)) && ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (3))))
          then (
            if (
              (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) &
                (281474976710655)) &
                (((- 1) << (((39 + ((38654705655 * ((v_level + ((- 1))))))) & (4294967295)))))) -
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
                (0)))
            then (
              rely ((511 >= (0)));
              match (
                (__table_maps_block_loop840
                  (z_to_nat 511)
                  false
                  (1 << ((39 + (((- 9) * (v_level))))))
                  (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                    (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295))))))
                  1
                  v_level
                  false
                  v_table
                  v_s2tte_is_x
                  st)
              ) with
              | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) =>
                rely (((v_s2tte_is_x_0.(poffset)) = (0)));
                rely (((v_table_0.(pbase)) = ("slot_rtt22")));
                rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
                (Some (v_retval_2, st_5))
              | None => None
              end)
            else (Some (false, st)))
          else (
            if ((v_level =? (2)) && ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (3)) =? (1))))
            then (
              if (
                (((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) &
                  (281474976710655)) &
                  (((- 1) << (((39 + ((38654705655 * ((v_level + ((- 1))))))) & (4294967295)))))) -
                  ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                    (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))))) =?
                  (0)))
              then (
                rely ((511 >= (0)));
                match (
                  (__table_maps_block_loop840
                    (z_to_nat 511)
                    false
                    (1 << ((39 + (((- 9) * (v_level))))))
                    (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_table.(poffset))) & (281474976710655)) &
                      (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295))))))
                    1
                    v_level
                    false
                    v_table
                    v_s2tte_is_x
                    st)
                ) with
                | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_5)) =>
                  rely (((v_s2tte_is_x_0.(poffset)) = (0)));
                  rely (((v_table_0.(pbase)) = ("slot_rtt22")));
                  rely (((((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_assigned")) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid")))) \/ (((v_s2tte_is_x_0.(pbase)) = ("s2tte_is_valid_ns")))));
                  (Some (v_retval_2, st_5))
                | None => None
                end)
              else (Some (false, st)))
            else (Some (false, st))))
        else (Some (false, st)))).
