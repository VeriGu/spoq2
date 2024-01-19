Record u_anon_7 :=
 mku_anon_7 {
    e_features_0 : Z;
    e_rec_params_padding0 : (ZMap.t Z)
  }.

Record u_anon_10 :=
 mku_anon_10 {
    e_gprs : (ZMap.t Z);
    e__rec_params_padding0 : (ZMap.t Z)
  }.

Record s_anon_14 :=
 mks_anon_14 {
    e_num_aux : Z;
    e_aux : (ZMap.t Z)
  }.

Record u_anon_11_154 :=
 mku_anon_11_154 {
    e__0 : s_anon_14;
    e___rec_params_padding0 : (ZMap.t Z)
  }.

Record s_rmi_rec_params :=
 mks_rmi_rec_params {
    e_rmi_rec_params_0 : u_anon_7;
    e_rmi_rec_params_1 : u_anon_7;
    e_rmi_rec_params_2 : u_anon_7;
    e_rmi_rec_params_3 : u_anon_10;
    e_rmi_rec_params_4 : u_anon_11_154
  }.

Definition load_u_anon_7 (sz: Z) (ofs: Z) (st: u_anon_7) : option Z :=
  if (ofs =? 0) then Some (st.(e_features_0)) else
  if (ofs >=? 8) && (ofs <? 256) then (
    let idx := (ofs - 8) / 1 in
    Some (st.(e_rec_params_padding0) @ idx)) else
  None.

Definition store_u_anon_7 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_7) : option u_anon_7 :=
  if (ofs =? 0) then Some (st.[e_features_0] :< v) else
  if (ofs >=? 8) && (ofs <? 256) then (
    let idx := (ofs - 8) / 1 in
    Some (st.[e_rec_params_padding0] :< (st.(e_rec_params_padding0) # idx == v))) else
  None.

Definition load_u_anon_10 (sz: Z) (ofs: Z) (st: u_anon_10) : option Z :=
  if (ofs >=? 0) && (ofs <? 64) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_gprs) @ idx)) else
  if (ofs >=? 64) && (ofs <? 1280) then (
    let idx := (ofs - 64) / 1 in
    Some (st.(e__rec_params_padding0) @ idx)) else
  None.

Definition store_u_anon_10 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_10) : option u_anon_10 :=
  if (ofs >=? 0) && (ofs <? 64) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_gprs] :< (st.(e_gprs) # idx == v))) else
  if (ofs >=? 64) && (ofs <? 1280) then (
    let idx := (ofs - 64) / 1 in
    Some (st.[e__rec_params_padding0] :< (st.(e__rec_params_padding0) # idx == v))) else
  None.

Definition load_s_anon_14 (sz: Z) (ofs: Z) (st: s_anon_14) : option Z :=
  if (ofs =? 0) then Some (st.(e_num_aux)) else
  if (ofs >=? 8) && (ofs <? 136) then (
    let idx := (ofs - 8) / 8 in
    Some (st.(e_aux) @ idx)) else
  None.

Definition store_s_anon_14 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_14) : option s_anon_14 :=
  if (ofs =? 0) then Some (st.[e_num_aux] :< v) else
  if (ofs >=? 8) && (ofs <? 136) then (
    let idx := (ofs - 8) / 8 in
    Some (st.[e_aux] :< (st.(e_aux) # idx == v))) else
  None.

Definition load_u_anon_11_154 (sz: Z) (ofs: Z) (st: u_anon_11_154) : option Z :=
  if (ofs >=? 0) && (ofs <? 136) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_14 sz elem_ofs (st.(e__0))) else
  if (ofs >=? 136) && (ofs <? 2048) then (
    let idx := (ofs - 136) / 1 in
    Some (st.(e___rec_params_padding0) @ idx)) else
  None.

Definition store_u_anon_11_154 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_11_154) : option u_anon_11_154 :=
  if (ofs >=? 0) && (ofs <? 136) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_14 sz elem_ofs v st.(e__0);
    Some (st.[e__0] :< ret)) else
  if (ofs >=? 136) && (ofs <? 2048) then (
    let idx := (ofs - 136) / 1 in
    Some (st.[e___rec_params_padding0] :< (st.(e___rec_params_padding0) # idx == v))) else
  None.

Definition load_s_rmi_rec_params (sz: Z) (ofs: Z) (st: s_rmi_rec_params) : option Z :=
  if (ofs >=? 0) && (ofs <? 256) then (
    let elem_ofs := ofs - 0 in
    load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_params_0))) else
  if (ofs >=? 256) && (ofs <? 512) then (
    let elem_ofs := ofs - 256 in
    load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_params_1))) else
  if (ofs >=? 512) && (ofs <? 768) then (
    let elem_ofs := ofs - 512 in
    load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_params_2))) else
  if (ofs >=? 768) && (ofs <? 2048) then (
    let elem_ofs := ofs - 768 in
    load_u_anon_10 sz elem_ofs (st.(e_rmi_rec_params_3))) else
  if (ofs >=? 2048) && (ofs <? 4096) then (
    let elem_ofs := ofs - 2048 in
    load_u_anon_11_154 sz elem_ofs (st.(e_rmi_rec_params_4))) else
  None.

Definition store_s_rmi_rec_params (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_rec_params) : option s_rmi_rec_params :=
  if (ofs >=? 0) && (ofs <? 256) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon_7 sz elem_ofs v st.(e_rmi_rec_params_0);
    Some (st.[e_rmi_rec_params_0] :< ret)) else
  if (ofs >=? 256) && (ofs <? 512) then (
    let elem_ofs := ofs - 256 in
    when ret == store_u_anon_7 sz elem_ofs v st.(e_rmi_rec_params_1);
    Some (st.[e_rmi_rec_params_1] :< ret)) else
  if (ofs >=? 512) && (ofs <? 768) then (
    let elem_ofs := ofs - 512 in
    when ret == store_u_anon_7 sz elem_ofs v st.(e_rmi_rec_params_2);
    Some (st.[e_rmi_rec_params_2] :< ret)) else
  if (ofs >=? 768) && (ofs <? 2048) then (
    let elem_ofs := ofs - 768 in
    when ret == store_u_anon_10 sz elem_ofs v st.(e_rmi_rec_params_3);
    Some (st.[e_rmi_rec_params_3] :< ret)) else
  if (ofs >=? 2048) && (ofs <? 4096) then (
    let elem_ofs := ofs - 2048 in
    when ret == store_u_anon_11_154 sz elem_ofs v st.(e_rmi_rec_params_4);
    Some (st.[e_rmi_rec_params_4] :< ret)) else
  None.

