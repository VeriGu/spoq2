Definition is_feat_vmid16_present_spec_mid (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32)), st)).

Definition arch_feat_get_pa_width_spec_mid (st: RData) : (option (Z * RData)) :=
  rely ((((0 - (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) <= (0)) /\ ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) < (7)))));
  (anno (((4 * (7)) = (28)));
  (anno (((28 * (0)) = (0)));
  (anno ((((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) + (0)) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
  (anno (((0 + ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
  if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (0))
  then (Some (32, st))
  else (
    (anno ((((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) + (0)) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
    (anno (((0 + ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
    if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (4))
    then (Some (36, st))
    else (
      (anno ((((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) + (0)) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
      (anno (((0 + ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
      if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (8))
      then (Some (40, st))
      else (
        (anno ((((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) + (0)) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
        (anno (((0 + ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
        if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (12))
        then (Some (42, st))
        else (
          (anno ((((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) + (0)) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
          (anno (((0 + ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
          if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (16))
          then (Some (44, st))
          else (
            (anno ((((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) + (0)) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
            (anno (((0 + ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))) = ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))))));
            if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (20))
            then (Some (48, st))
            else (Some (52, st))))))))))))))))))))).

Definition is_feat_lpa2_4k_present_spec_mid (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (16492674416640)) =? (3298534883328)), st)).

Definition is_feat_sve_present_spec_mid (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0)), st)).

Definition access_len_spec_mid (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  if (((v_esr >> (22)) & (3)) =? (2))
  then (Some (4, st))
  else (
    if (((v_esr >> (22)) & (3)) =? (0))
    then (Some (1, st))
    else (
      if (((v_esr >> (22)) & (3)) =? (1))
      then (Some (2, st))
      else (Some (8, st)))).

