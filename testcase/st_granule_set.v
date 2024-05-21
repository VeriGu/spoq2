Record s_granule_set :=
 mks_granule_set {
    e_idx : Z;
    e_addr : Z;
    e_state : Z;
    e_g : Z;
    e_g_ret : Z
  }.

Definition load_s_granule_set (sz: Z) (ofs: Z) (st: s_granule_set) : option Z :=
  if (ofs =? 0) then Some (st.(e_idx)) else
  if (ofs =? 8) then Some (st.(e_addr)) else
  if (ofs =? 16) then Some (st.(e_state)) else
  if (ofs =? 24) then Some (st.(e_g)) else
  if (ofs =? 32) then Some (st.(e_g_ret)) else
  None.

Definition store_s_granule_set (sz: Z) (ofs: Z) (v: Z) (st: s_granule_set) : option s_granule_set :=
  if (ofs =? 0) then Some (st.[e_idx] :< v) else
  if (ofs =? 8) then Some (st.[e_addr] :< v) else
  if (ofs =? 16) then Some (st.[e_state] :< v) else
  if (ofs =? 24) then Some (st.[e_g] :< v) else
  if (ofs =? 32) then Some (st.[e_g_ret] :< v) else
  None.
