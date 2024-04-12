Definition read_id_aa64mmfr0_el1_spec (st: RData) : (option (Z * RData)) :=
  when v_0, st == ((iasm_18_spec st));
  let __return__ := true in
  let __retval__ := v_0 in
  (Some (__retval__, st)).

