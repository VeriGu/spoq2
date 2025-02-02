Definition status_ptr_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
  (Some ((int_to_ptr (0 - (v_0))), st)).

