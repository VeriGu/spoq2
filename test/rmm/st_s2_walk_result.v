Record s_s2_walk_result :=
 mks_s2_walk_result {
    e_pa : Z;
    e_rtt_level : Z;
    e_ripas : Z;
    e_destroyed : Z;
    e_llt : Z
  }.

Definition load_s_s2_walk_result (sz: Z) (ofs: Z) (st: s_s2_walk_result) : option Z :=
  if (ofs =? 0) then Some (st.(e_pa)) else
  if (ofs =? 8) then Some (st.(e_rtt_level)) else
  if (ofs =? 16) then Some (st.(e_ripas)) else
  if (ofs =? 20) then Some (st.(e_destroyed)) else
  if (ofs =? 24) then Some (st.(e_llt)) else
  None.

Definition store_s_s2_walk_result (sz: Z) (ofs: Z) (v: Z) (st: s_s2_walk_result) : option s_s2_walk_result :=
  if (ofs =? 0) then Some (st.[e_pa] :< v) else
  if (ofs =? 8) then Some (st.[e_rtt_level] :< v) else
  if (ofs =? 16) then Some (st.[e_ripas] :< v) else
  if (ofs =? 20) then Some (st.[e_destroyed] :< v) else
  if (ofs =? 24) then Some (st.[e_llt] :< v) else
  None.
