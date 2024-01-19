Definition get_feature_register_0_spec_mid (st: RData) : (option (Z * RData)) :=
  when ret == ((arch_feat_get_pa_width_spec' st));
  if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (16492674416640)) =? (3298534883328))
  then (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
    then (
      (Some (
        ((((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' ((ret |' (256)))) |' (809501184)) |' ((((st.(share)).(gv_g_sve_max_vq)) << (10))))  ,
        st
      )))
    else (Some ((((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' ((ret |' (256)))) |' (809500672)), st)))
  else (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
    then (Some (((((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' (ret)) |' (809501184)) |' ((((st.(share)).(gv_g_sve_max_vq)) << (10)))), st))
    else (Some ((((((((st.(priv)).(pcpu_regs)).(pcpu_pmcr_el0)) << (12)) & (260046848)) |' (ret)) |' (809500672)), st))).

