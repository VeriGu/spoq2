Definition pack_struct_return_code_spec (v_return_code_coerce: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((v_return_code_coerce >> (24)) & (4294967040)) |' ((v_return_code_coerce & (4294967295)))), st)).

Definition make_return_code_spec (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_index << (32)) + (v_status)), st)).

