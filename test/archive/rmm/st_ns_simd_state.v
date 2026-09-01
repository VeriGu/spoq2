Record s_ns_simd_state :=
 mks_ns_simd_state {
    e_ns_simd : s_simd_state;
    e_ns_zcr_el2 : Z;
    e_ns_saved : Z
  }.

Definition load_s_ns_simd_state (sz: Z) (ofs: Z) (st: s_ns_simd_state) : option Z :=
  if (ofs >=? 0) && (ofs <? 8784) then (
    let elem_ofs := ofs - 0 in
    load_s_simd_state sz elem_ofs (st.(e_ns_simd))) else
  if (ofs =? 8784) then Some (st.(e_ns_zcr_el2)) else
  if (ofs =? 8792) then Some (st.(e_ns_saved)) else
  None.

Definition store_s_ns_simd_state (sz: Z) (ofs: Z) (v: Z) (st: s_ns_simd_state) : option s_ns_simd_state :=
  if (ofs >=? 0) && (ofs <? 8784) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_simd_state sz elem_ofs v st.(e_ns_simd);
    Some (st.[e_ns_simd] :< ret)) else
  if (ofs =? 8784) then Some (st.[e_ns_zcr_el2] :< v) else
  if (ofs =? 8792) then Some (st.[e_ns_saved] :< v) else
  None.

