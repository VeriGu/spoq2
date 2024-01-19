Definition get_feature_register_0_spec' (st: RData) : (option Z) :=
  when ret == ((arch_feat_get_pa_width_spec' st));
  if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (16492674416640)) =? (3298534883328))
  then (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
    then (Some ((((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' ((ret |' (256)))) |' (809501184)) |' ((((st.(share)).(gv_g_sve_max_vq)) << (10)))))
    else (Some (((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' ((ret |' (256)))) |' (809500672))))
  else (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
    then (Some ((((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' (ret)) |' (809501184)) |' ((((st.(share)).(gv_g_sve_max_vq)) << (10)))))
    else (Some (((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' (ret)) |' (809500672)))).

Definition get_feature_register_0_spec (st: RData) : (option (Z * RData)) :=
  when ret == ((get_feature_register_0_spec' st));
  (Some (ret, st)).

