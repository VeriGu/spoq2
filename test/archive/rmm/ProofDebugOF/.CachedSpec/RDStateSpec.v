Definition get_rd_state_locked_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)), st)).

Definition set_rd_state_spec (v_rd: Ptr) (v_state: Z) (st: RData) : (option RData) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_RD) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).[g_rd] :<
        (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).[e_rd_rd_state] :< v_state))))).

