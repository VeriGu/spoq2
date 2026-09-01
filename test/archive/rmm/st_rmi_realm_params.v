Record u_anon_0_95 :=
 mku_anon_0_95 {
    e_union_anon_0_95_0 : (ZMap.t Z)
  }.

Record u_anon_1_96 :=
 mku_anon_1_96 {
    e_union_anon_1_96_0 : (ZMap.t Z)
  }.

Record s_anon_97 :=
 mks_anon_97 {
    e_vmid : Z;
    e_rtt_base : Z;
    e_rtt_level_start : Z;
    e_rtt_num_start : Z
  }.

Record u_anon_2_98 :=
 mku_anon_2_98 {
    e_union_anon_2_98_0 : s_anon_97;
    e_union_anon_2_98_1 : (ZMap.t Z)
  }.

Record s_rmi_realm_params :=
 mks_rmi_realm_params {
    e_rmi_realm_params_0 : u_anon_7;
    e_rmi_realm_params_1 : u_anon_0_95;
    e_rmi_realm_params_2 : u_anon_1_96;
    e_rmi_realm_params_3 : u_anon_2_98
  }.

Definition load_u_anon_0_95 (sz: Z) (ofs: Z) (st: u_anon_0_95) : option Z :=
  if (ofs >=? 0) && (ofs <? 768) then (
    let idx := (ofs - 0) / 1 in
    Some (st.(e_union_anon_0_95_0) @ idx)) else
  None.

Definition store_u_anon_0_95 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_0_95) : option u_anon_0_95 :=
  if (ofs >=? 0) && (ofs <? 768) then (
    let idx := (ofs - 0) / 1 in
    Some (st.[e_union_anon_0_95_0] :< (st.(e_union_anon_0_95_0) # idx == v))) else
  None.

Definition load_u_anon_1_96 (sz: Z) (ofs: Z) (st: u_anon_1_96) : option Z :=
  if (ofs >=? 0) && (ofs <? 1024) then (
    let idx := (ofs - 0) / 1 in
    Some (st.(e_union_anon_1_96_0) @ idx)) else
  None.

Definition store_u_anon_1_96 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_1_96) : option u_anon_1_96 :=
  if (ofs >=? 0) && (ofs <? 1024) then (
    let idx := (ofs - 0) / 1 in
    Some (st.[e_union_anon_1_96_0] :< (st.(e_union_anon_1_96_0) # idx == v))) else
  None.

Definition load_s_anon_97 (sz: Z) (ofs: Z) (st: s_anon_97) : option Z :=
  if (ofs =? 0) then Some (st.(e_vmid)) else
  if (ofs =? 8) then Some (st.(e_rtt_base)) else
  if (ofs =? 16) then Some (st.(e_rtt_level_start)) else
  if (ofs =? 24) then Some (st.(e_rtt_num_start)) else
  None.

Definition store_s_anon_97 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_97) : option s_anon_97 :=
  if (ofs =? 0) then Some (st.[e_vmid] :< v) else
  if (ofs =? 8) then Some (st.[e_rtt_base] :< v) else
  if (ofs =? 16) then Some (st.[e_rtt_level_start] :< v) else
  if (ofs =? 24) then Some (st.[e_rtt_num_start] :< v) else
  None.

Definition load_u_anon_2_98 (sz: Z) (ofs: Z) (st: u_anon_2_98) : option Z :=
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_97 sz elem_ofs (st.(e_union_anon_2_98_0))) else
  if (ofs >=? 1) && (ofs <? 2017) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_2_98_1) @ idx)) else
  None.

Definition store_u_anon_2_98 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_2_98) : option u_anon_2_98 :=
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_97 sz elem_ofs v st.(e_union_anon_2_98_0);
    Some (st.[e_union_anon_2_98_0] :< ret)) else
  if (ofs >=? 1) && (ofs <? 2017) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_2_98_1] :< (st.(e_union_anon_2_98_1) # idx == v))) else
  None.

Definition load_s_rmi_realm_params (sz: Z) (ofs: Z) (st: s_rmi_realm_params) : option Z :=
  if (ofs >=? 0) && (ofs <? 256) then (
    let elem_ofs := ofs - 0 in
    load_u_anon_7 sz elem_ofs (st.(e_rmi_realm_params_0))) else
  if (ofs >=? 256) && (ofs <? 1024) then (
    let elem_ofs := ofs - 256 in
    load_u_anon_0_95 sz elem_ofs (st.(e_rmi_realm_params_1))) else
  if (ofs >=? 1024) && (ofs <? 2048) then (
    let elem_ofs := ofs - 1024 in
    load_u_anon_1_96 sz elem_ofs (st.(e_rmi_realm_params_2))) else
  if (ofs >=? 2048) && (ofs <? 4096) then (
    let elem_ofs := ofs - 2048 in
    load_u_anon_2_98 sz elem_ofs (st.(e_rmi_realm_params_3))) else
  None.

Definition store_s_rmi_realm_params (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_realm_params) : option s_rmi_realm_params :=
  if (ofs >=? 0) && (ofs <? 256) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon_7 sz elem_ofs v st.(e_rmi_realm_params_0);
    Some (st.[e_rmi_realm_params_0] :< ret)) else
  if (ofs >=? 256) && (ofs <? 1024) then (
    let elem_ofs := ofs - 256 in
    when ret == store_u_anon_0_95 sz elem_ofs v st.(e_rmi_realm_params_1);
    Some (st.[e_rmi_realm_params_1] :< ret)) else
  if (ofs >=? 1024) && (ofs <? 2048) then (
    let elem_ofs := ofs - 1024 in
    when ret == store_u_anon_1_96 sz elem_ofs v st.(e_rmi_realm_params_2);
    Some (st.[e_rmi_realm_params_2] :< ret)) else
  if (ofs >=? 2048) && (ofs <? 4096) then (
    let elem_ofs := ofs - 2048 in
    when ret == store_u_anon_2_98 sz elem_ofs v st.(e_rmi_realm_params_3);
    Some (st.[e_rmi_realm_params_3] :< ret)) else
  None.
