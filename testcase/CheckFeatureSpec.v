Definition is_feat_vmid16_present_spec (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32)), st)).

Definition arch_feat_get_pa_width_spec' (st: RData) : (option Z) :=
  rely ((((0 - (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) <= (0)) /\ ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) < (7)))));
  if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (0))
  then (Some 32)
  else (
    if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (4))
    then (Some 36)
    else (
      if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (8))
      then (Some 40)
      else (
        if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (12))
        then (Some 42)
        else (
          if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (16))
          then (Some 44)
          else (
            if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (20))
            then (Some 48)
            else (Some 52)))))).

Definition arch_feat_get_pa_width_spec (st: RData) : (option (Z * RData)) :=
  when ret == ((arch_feat_get_pa_width_spec' st));
  (Some (ret, st)).

Definition is_feat_lpa2_4k_present_spec (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (16492674416640)) =? (3298534883328)), st)).

Definition is_feat_sve_present_spec (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0)), st)).

Definition access_len_spec' (v_esr: Z) (st: RData) : Z :=
  if (((v_esr >> (22)) & (3)) =? (2))
  then 4
  else (
    if (((v_esr >> (22)) & (3)) =? (0))
    then 1
    else (
      if (((v_esr >> (22)) & (3)) =? (1))
      then 2
      else 8)).

Definition access_len_spec (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (access_len_spec' v_esr st) in
  (Some (ret, st)).

