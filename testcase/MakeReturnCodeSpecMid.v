Definition make_return_code_spec_mid (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_index << (32)) + (v_status)), st)).

Definition pack_struct_return_code_spec_mid (v_return_code_coerce: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((v_return_code_coerce >> (24)) & (4294967040)) |' ((v_return_code_coerce & (4294967295)))), st)).

