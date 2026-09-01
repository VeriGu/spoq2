Record s_smc_result :=
 mks_smc_result {
    e_x : (ZMap.t Z)
   }.

Definition load_s_smc_result (sz: Z) (ofs: Z) (st: s_smc_result) : option Z :=
  if (ofs >=? 0) && (ofs <? 40) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_x) @ idx)) else
  None.

Definition store_s_smc_result (sz: Z) (ofs: Z) (v: Z) (st: s_smc_result) : option s_smc_result :=
  if (ofs >=? 0) && (ofs <? 40) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_x] :< (st.(e_x) # idx == v))) else
  None.
