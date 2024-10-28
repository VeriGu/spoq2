Definition smc_rec_destroy_spec (v_rec_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rec_addr & (4095)) =? (0))
  then (
      if ((v_rec_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
          rely ((((0 - ((v_rec_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rec_addr / (GRANULE_SIZE)) < (1048576)))));
          rely (((((((st.(share)).(granules)) @ (v_rec_addr / (GRANULE_SIZE))).(e_state)) - (3)) = (0)));
          when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
          if ((((((lens 45 st).(share)).(granules)) @ (v_rec_addr / (GRANULE_SIZE))).(e_refcount)) =? (0))
          then (
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              rely (
                  (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)))) /\
                     (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (18446744073705226240)) < (0)))));
              rely ((("granules" = ("granules")) /\ (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) mod (16)) = (0)))));
              if (
                  (((((((lens 277 st).(share)).(granules)) @ (1152921504605528063 + ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) / (ST_GRANULE_SIZE))))).(e_refcount)) +
                      ((- 1))) <?
                     (0)))
              then None
              else (Some (0, (lens 278 st))))
          else (Some (5, (lens 50 st)))))
           else (Some (1, st)).
