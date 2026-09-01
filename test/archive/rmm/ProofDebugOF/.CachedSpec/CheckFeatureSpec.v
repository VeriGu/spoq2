Definition is_feat_vmid16_present_spec (st: RData) : (option (bool * RData)) :=
  (Some ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32)), st)).

