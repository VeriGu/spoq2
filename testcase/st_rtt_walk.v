Record s_rtt_walk :=
 mks_rtt_walk {
    e_g_llt : Z;
    e_index : Z;
    e_last_level : Z
  }.

Definition load_s_rtt_walk (sz: Z) (ofs: Z) (st: s_rtt_walk) : option Z :=
  if (ofs =? 0) then Some (st.(e_g_llt)) else
  if (ofs =? 8) then Some (st.(e_index)) else
  if (ofs =? 16) then Some (st.(e_last_level)) else
  None.

Definition store_s_rtt_walk (sz: Z) (ofs: Z) (v: Z) (st: s_rtt_walk) : option s_rtt_walk :=
  if (ofs =? 0) then Some (st.[e_g_llt] :< v) else
  if (ofs =? 8) then Some (st.[e_index] :< v) else
  if (ofs =? 16) then Some (st.[e_last_level] :< v) else
  None.
