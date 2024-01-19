Definition rmm_el3_ifc_gtsi_delegate_spec_mid (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  when v_call, st_0 == ((monitor_call_state_oracle 3288334768 v_addr 0 0 0 0 0 st));
  (Some (v_call, st_0)).

Definition rmm_el3_ifc_gtsi_undelegate_spec_mid (v_addr: Z) (st: RData) : (option (Z * RData)) :=
  when v_call, st_0 == ((monitor_call_state_oracle 3288334769 v_addr 0 0 0 0 0 st));
  (Some (v_call, st_0)).

