Record s_fpu_state :=
 mks_fpu_state {
    e_q : (ZMap.t Z);
    e_fpsr : Z;
    e_fpcr : Z
  }.

Record u_anon_6 :=
 mku_anon_6 {
    e_fpu : s_fpu_state;
    e_padding0 : (ZMap.t Z)
  }.

Record s_simd_state :=
 mks_simd_state {
    e_t : u_anon_6;
    e_simd_type : Z
  }.

Definition load_s_fpu_state (sz: Z) (ofs: Z) (st: s_fpu_state) : option Z :=
  if (ofs >=? 0) && (ofs <? 512) then (
    let idx := (ofs - 0) / 16 in
    Some (st.(e_q) @ idx)) else
  if (ofs =? 512) then Some (st.(e_fpsr)) else
  if (ofs =? 520) then Some (st.(e_fpcr)) else
  None.

Definition store_s_fpu_state (sz: Z) (ofs: Z) (v: Z) (st: s_fpu_state) : option s_fpu_state :=
  if (ofs >=? 0) && (ofs <? 512) then (
    let idx := (ofs - 0) / 16 in
    Some (st.[e_q] :< (st.(e_q) # idx == v))) else
  if (ofs =? 512) then Some (st.[e_fpsr] :< v) else
  if (ofs =? 520) then Some (st.[e_fpcr] :< v) else
  None.

Definition load_u_anon_6 (sz: Z) (ofs: Z) (st: u_anon_6) : option Z :=
  if (ofs >=? 0) && (ofs <? 528) then (
    let elem_ofs := ofs - 0 in
    load_s_fpu_state sz elem_ofs (st.(e_fpu))) else
  if (ofs >=? 528) && (ofs <? 8768) then (
    let idx := (ofs - 528) / 1 in
    Some (st.(e_padding0) @ idx)) else
  None.

Definition store_u_anon_6 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_6) : option u_anon_6 :=
  if (ofs >=? 0) && (ofs <? 528) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_fpu_state sz elem_ofs v st.(e_fpu);
    Some (st.[e_fpu] :< ret)) else
  if (ofs >=? 528) && (ofs <? 8768) then (
    let idx := (ofs - 528) / 1 in
    Some (st.[e_padding0] :< (st.(e_padding0) # idx == v))) else
  None.

Definition load_s_simd_state (sz: Z) (ofs: Z) (st: s_simd_state) : option Z :=
  if (ofs >=? 0) && (ofs <? 8768) then (
    let elem_ofs := ofs - 0 in
    load_u_anon_6 sz elem_ofs (st.(e_t))) else
  if (ofs =? 8768) then Some (st.(e_simd_type)) else
  None.

Definition store_s_simd_state (sz: Z) (ofs: Z) (v: Z) (st: s_simd_state) : option s_simd_state :=
  if (ofs >=? 0) && (ofs <? 8768) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon_6 sz elem_ofs v st.(e_t);
    Some (st.[e_t] :< ret)) else
  if (ofs =? 8768) then Some (st.[e_simd_type] :< v) else
  None.

