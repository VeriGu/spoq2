Definition table_maps_valid_block_spec (v_table: Ptr) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  when v_call, st_0 == ((__table_maps_block_spec v_table v_level (mkPtr "s2tte_is_valid" 0) st));
  (Some (v_call, st_0)).

Definition table_is_unassigned_block_spec (v_table: Ptr) (v_ripas: Ptr) (st: RData) : (option (bool * RData)) :=
  when v_call, st_0 == ((__table_is_uniform_block_spec v_table (mkPtr "s2tte_is_unassigned" 0) v_ripas st));
  (Some (v_call, st_0)).

Definition table_is_destroyed_block_spec (v_table: Ptr) (st: RData) : (option (bool * RData)) :=
  when v_call, st_0 == ((__table_is_uniform_block_spec v_table (mkPtr "s2tte_is_destroyed" 0) (mkPtr "null" 0) st));
  (Some (v_call, st_0)).

Definition table_maps_valid_ns_block_spec (v_table: Ptr) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  when v_call, st_0 == ((__table_maps_block_spec v_table v_level (mkPtr "s2tte_is_valid_ns" 0) st));
  (Some (v_call, st_0)).

Definition table_maps_assigned_block_spec (v_table: Ptr) (v_level: Z) (st: RData) : (option (bool * RData)) :=
  when v_call, st_0 == ((__table_maps_block_spec v_table v_level (mkPtr "s2tte_is_assigned" 0) st));
  (Some (v_call, st_0)).

