Definition validate_feature_register_0_spec' (v_value: Z) (st: RData) : (option bool) :=
  when ret == ((get_feature_register_0_spec' st));
  if ((v_value & (255)) <? (32))
  then (Some false)
  else (
    if (((v_value & (255)) - ((ret & (255)))) >? (0))
    then (Some false)
    else (
      if ((v_value & (256)) =? (0))
      then (
        if ((v_value & (4194304)) =? (0))
        then (
          if ((v_value & (512)) =? (0))
          then (Some true)
          else (
            if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
            then (
              if ((((v_value >> (10)) & (15)) - (((st.(share)).(gv_g_sve_max_vq)))) >? (0))
              then (Some false)
              else (Some true))
            else (Some false)))
        else (
          if (((Z.lxor ret v_value) & (260046848)) =? (0))
          then (
            if ((v_value & (512)) =? (0))
            then (Some true)
            else (
              if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
              then (
                if ((((v_value >> (10)) & (15)) - (((st.(share)).(gv_g_sve_max_vq)))) >? (0))
                then (Some false)
                else (Some true))
              else (Some false)))
          else (Some false)))
      else (
        if ((ret & (256)) =? (0))
        then (Some false)
        else (
          if ((v_value & (4194304)) =? (0))
          then (
            if ((v_value & (512)) =? (0))
            then (Some true)
            else (
              if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
              then (
                if ((((v_value >> (10)) & (15)) - (((st.(share)).(gv_g_sve_max_vq)))) >? (0))
                then (Some false)
                else (Some true))
              else (Some false)))
          else (
            if (((Z.lxor ret v_value) & (260046848)) =? (0))
            then (
              if ((v_value & (512)) =? (0))
              then (Some true)
              else (
                if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64pfr0_el1)) & (64424509440)) <>? (0))
                then (
                  if ((((v_value >> (10)) & (15)) - (((st.(share)).(gv_g_sve_max_vq)))) >? (0))
                  then (Some false)
                  else (Some true))
                else (Some false)))
            else (Some false)))))).

Definition validate_feature_register_0_spec (v_value: Z) (st: RData) : (option (bool * RData)) :=
  when ret == ((validate_feature_register_0_spec' v_value st));
  (Some (ret, st)).

