Definition rmm_el3_ifc_gtsi_delegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))));
  (Some (0, (st.[share].[gpt] :< (((st.(share)).(gpt)) # (v_addr / (GRANULE_SIZE)) == true)))).

Definition rmm_el3_ifc_gtsi_undelegate_spec (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((((st.(share)).(granules)) @ (v_addr / (GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))));
  (Some (0, (st.[share].[gpt] :< (((st.(share)).(gpt)) # (v_addr / (GRANULE_SIZE)) == false)))).

