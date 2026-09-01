Record u_anon_12 :=
 mku_anon_12 {
    e_union_anon_12_0 : Z;
    e_union_anon_12_1 : (ZMap.t Z)
  }.

Record u_anon_1 :=
 mku_anon_1 {
    e_union_anon_1_0 : (ZMap.t Z);
    e_union_anon_1_1 : (ZMap.t Z)
  }.

Record s_anon_14 :=
 mks_anon_14 {
    e_num_aux : Z;
    e_aux : (ZMap.t Z)
  }.

Record u_anon_1_15 :=
 mku_anon_1_15 {
    e_union_anon_1_15_0 : s_anon_14;
    e_union_anon_1_15_1 : (ZMap.t Z)
  }.

Record s_rmi_rec_entry :=
 mks_rmi_rec_entry {
    e_rmi_rec_entry_0 : u_anon_12;
    e_rmi_rec_entry_1 : u_anon_1;
    e_rmi_rec_entry_2 : u_anon_1_15
  }.

Record u_anon_7_148 :=
 mku_anon_7_148 {
    e_union_anon_7_148_0 : s_rmi_rec_entry
  }.

Record u_anon_7 :=
 mku_anon_7 {
    e_union_anon_7_0 : Z;
    e_union_anon_7_1 : (ZMap.t Z)
  }.

Record s_anon_8 :=
 mks_anon_8 {
    e_esr : Z;
    e_hpfar : Z;
    e_far : Z
  }.

Record u_anon_0 :=
 mku_anon_0 {
    e_union_anon_0_0 : s_anon_8;
    e_union_anon_0_1 : (ZMap.t Z)
  }.

Record s_anon_3 :=
 mks_anon_3 {
    e_gicv3_hcr : Z;
    e_gicv3_lrs : (ZMap.t Z);
    e_gicv3_misr : Z;
    e_gicv3_vmcr : Z
  }.

Record u_anon_2 :=
 mku_anon_2 {
    e_union_anon_2_0 : s_anon_3;
    e_union_anon_2_1 : (ZMap.t Z)
  }.

Record s_anon_5 :=
 mks_anon_5 {
    e_cntp_ctl : Z;
    e_cntp_cval : Z;
    e_cntv_ctl : Z;
    e_cntv_cval : Z
  }.

Record u_anon_4 :=
 mku_anon_4 {
    e_union_anon_4_0 : s_anon_5;
    e_union_anon_4_1 : (ZMap.t Z)
  }.

Record s_anon_7 :=
 mks_anon_7 {
    e_ripas_base : Z;
    e_ripas_size : Z;
    e_ripas_value : Z
  }.

Record u_anon_6_9 :=
 mku_anon_6_9 {
    e_union_anon_6_9_0 : s_anon_7;
    e_union_anon_6_9_1 : (ZMap.t Z)
  }.

Record u_anon_8 :=
 mku_anon_8 {
    e_union_anon_8_0 : Z;
    e_union_anon_8_1 : (ZMap.t Z)
  }.

Record u_anon_9 :=
 mku_anon_9 {
    e_union_anon_9_0 : Z
  }.

Record u_anon_11 :=
 mku_anon_11 {
    e_union_anon_11_0 : Z;
    e_union_anon_11_1 : (ZMap.t Z)
  }.

Record s_rmi_rec_exit :=
 mks_rmi_rec_exit {
    e_rmi_rec_exit_0 : u_anon_7;
    e_rmi_rec_exit_1 : u_anon_0;
    e_rmi_rec_exit_2 : u_anon_1;
    e_rmi_rec_exit_3 : u_anon_2;
    e_rmi_rec_exit_4 : u_anon_4;
    e_rmi_rec_exit_5 : u_anon_6_9;
    e_rmi_rec_exit_6 : u_anon_8;
    e_rmi_rec_exit_7 : u_anon_9;
    e_rmi_rec_exit_8 : u_anon_9;
    e_rmi_rec_exit_9 : u_anon_11
  }.

Record u_anon_12_150 :=
 mku_anon_12_150 {
    e_union_anon_12_150_0 : s_rmi_rec_exit
  }.

Record s_rmi_rec_run :=
 mks_rmi_rec_run {
    e_rmi_rec_run_0 : u_anon_7_148;
    e_rmi_rec_run_1 : u_anon_12_150
  }.

Definition load_u_anon_12 (sz: Z) (ofs: Z) (st: u_anon_12) : option Z :=
  if (ofs =? 0) then Some (st.(e_union_anon_12_0)) else
  if (ofs >=? 1) && (ofs <? 505) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_12_1) @ idx)) else
  None.

Definition store_u_anon_12 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_12) : option u_anon_12 :=
  if (ofs =? 0) then Some (st.[e_union_anon_12_0] :< v) else
  if (ofs >=? 1) && (ofs <? 505) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_12_1] :< (st.(e_union_anon_12_1) # idx == v))) else
  None.

Definition load_u_anon_1 (sz: Z) (ofs: Z) (st: u_anon_1) : option Z :=
  if (ofs >=? 0) && (ofs <? 248) then (
    let idx := (ofs - 0) / 8 in
    Some (st.(e_union_anon_1_0) @ idx)) else
  if (ofs >=? 1) && (ofs <? 9) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_1_1) @ idx)) else
  None.

Definition store_u_anon_1 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_1) : option u_anon_1 :=
  if (ofs >=? 0) && (ofs <? 248) then (
    let idx := (ofs - 0) / 8 in
    Some (st.[e_union_anon_1_0] :< (st.(e_union_anon_1_0) # idx == v))) else
  if (ofs >=? 1) && (ofs <? 9) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_1_1] :< (st.(e_union_anon_1_1) # idx == v))) else
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

Definition load_u_anon_1_15 (sz: Z) (ofs: Z) (st: u_anon_1_15) : option Z :=
  if (ofs >=? 0) && (ofs <? 136) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_14 sz elem_ofs (st.(e_union_anon_1_15_0))) else
  if (ofs >=? 1) && (ofs <? 1145) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_1_15_1) @ idx)) else
  None.

Definition store_u_anon_1_15 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_1_15) : option u_anon_1_15 :=
  if (ofs >=? 0) && (ofs <? 136) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_14 sz elem_ofs v st.(e_union_anon_1_15_0);
    Some (st.[e_union_anon_1_15_0] :< ret)) else
  if (ofs >=? 1) && (ofs <? 1145) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_1_15_1] :< (st.(e_union_anon_1_15_1) # idx == v))) else
  None.

Definition load_s_rmi_rec_entry (sz: Z) (ofs: Z) (st: s_rmi_rec_entry) : option Z :=
  if (ofs >=? 0) && (ofs <? 512) then (
    let elem_ofs := ofs - 0 in
    load_u_anon_12 sz elem_ofs (st.(e_rmi_rec_entry_0))) else
  if (ofs >=? 512) && (ofs <? 768) then (
    let elem_ofs := ofs - 512 in
    load_u_anon_1 sz elem_ofs (st.(e_rmi_rec_entry_1))) else
  if (ofs >=? 768) && (ofs <? 2048) then (
    let elem_ofs := ofs - 768 in
    load_u_anon_1_15 sz elem_ofs (st.(e_rmi_rec_entry_2))) else
  None.

Definition store_s_rmi_rec_entry (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_rec_entry) : option s_rmi_rec_entry :=
  if (ofs >=? 0) && (ofs <? 512) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon_12 sz elem_ofs v st.(e_rmi_rec_entry_0);
    Some (st.[e_rmi_rec_entry_0] :< ret)) else
  if (ofs >=? 512) && (ofs <? 768) then (
    let elem_ofs := ofs - 512 in
    when ret == store_u_anon_1 sz elem_ofs v st.(e_rmi_rec_entry_1);
    Some (st.[e_rmi_rec_entry_1] :< ret)) else
  if (ofs >=? 768) && (ofs <? 2048) then (
    let elem_ofs := ofs - 768 in
    when ret == store_u_anon_1_15 sz elem_ofs v st.(e_rmi_rec_entry_2);
    Some (st.[e_rmi_rec_entry_2] :< ret)) else
  None.

Definition load_u_anon_7_148 (sz: Z) (ofs: Z) (st: u_anon_7_148) : option Z :=
  if (ofs >=? 0) && (ofs <? 2048) then (
    let elem_ofs := ofs - 0 in
    load_s_rmi_rec_entry sz elem_ofs (st.(e_union_anon_7_148_0))) else
  None.

Definition store_u_anon_7_148 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_7_148) : option u_anon_7_148 :=
  if (ofs >=? 0) && (ofs <? 2048) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_rmi_rec_entry sz elem_ofs v st.(e_union_anon_7_148_0);
    Some (st.[e_union_anon_7_148_0] :< ret)) else
  None.

Definition load_u_anon_7 (sz: Z) (ofs: Z) (st: u_anon_7) : option Z :=
  if (ofs =? 0) then Some (st.(e_union_anon_7_0)) else
  if (ofs >=? 1) && (ofs <? 249) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_7_1) @ idx)) else
  None.

Definition store_u_anon_7 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_7) : option u_anon_7 :=
  if (ofs =? 0) then Some (st.[e_union_anon_7_0] :< v) else
  if (ofs >=? 1) && (ofs <? 249) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_7_1] :< (st.(e_union_anon_7_1) # idx == v))) else
  None.

Definition load_s_anon_8 (sz: Z) (ofs: Z) (st: s_anon_8) : option Z :=
  if (ofs =? 0) then Some (st.(e_esr)) else
  if (ofs =? 8) then Some (st.(e_hpfar)) else
  if (ofs =? 16) then Some (st.(e_far)) else
  None.

Definition store_s_anon_8 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_8) : option s_anon_8 :=
  if (ofs =? 0) then Some (st.[e_esr] :< v) else
  if (ofs =? 8) then Some (st.[e_hpfar] :< v) else
  if (ofs =? 16) then Some (st.[e_far] :< v) else
  None.

Definition load_u_anon_0 (sz: Z) (ofs: Z) (st: u_anon_0) : option Z :=
  if (ofs >=? 0) && (ofs <? 24) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_8 sz elem_ofs (st.(e_union_anon_0_0))) else
  if (ofs >=? 1) && (ofs <? 233) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_0_1) @ idx)) else
  None.

Definition store_u_anon_0 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_0) : option u_anon_0 :=
  if (ofs >=? 0) && (ofs <? 24) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_8 sz elem_ofs v st.(e_union_anon_0_0);
    Some (st.[e_union_anon_0_0] :< ret)) else
  if (ofs >=? 1) && (ofs <? 233) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_0_1] :< (st.(e_union_anon_0_1) # idx == v))) else
  None.

Definition load_s_anon_3 (sz: Z) (ofs: Z) (st: s_anon_3) : option Z :=
  if (ofs =? 0) then Some (st.(e_gicv3_hcr)) else
  if (ofs >=? 8) && (ofs <? 136) then (
    let idx := (ofs - 8) / 8 in
    Some (st.(e_gicv3_lrs) @ idx)) else
  if (ofs =? 136) then Some (st.(e_gicv3_misr)) else
  if (ofs =? 144) then Some (st.(e_gicv3_vmcr)) else
  None.

Definition store_s_anon_3 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_3) : option s_anon_3 :=
  if (ofs =? 0) then Some (st.[e_gicv3_hcr] :< v) else
  if (ofs >=? 8) && (ofs <? 136) then (
    let idx := (ofs - 8) / 8 in
    Some (st.[e_gicv3_lrs] :< (st.(e_gicv3_lrs) # idx == v))) else
  if (ofs =? 136) then Some (st.[e_gicv3_misr] :< v) else
  if (ofs =? 144) then Some (st.[e_gicv3_vmcr] :< v) else
  None.

Definition load_u_anon_2 (sz: Z) (ofs: Z) (st: u_anon_2) : option Z :=
  if (ofs >=? 0) && (ofs <? 152) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_3 sz elem_ofs (st.(e_union_anon_2_0))) else
  if (ofs >=? 1) && (ofs <? 105) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_2_1) @ idx)) else
  None.

Definition store_u_anon_2 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_2) : option u_anon_2 :=
  if (ofs >=? 0) && (ofs <? 152) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_3 sz elem_ofs v st.(e_union_anon_2_0);
    Some (st.[e_union_anon_2_0] :< ret)) else
  if (ofs >=? 1) && (ofs <? 105) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_2_1] :< (st.(e_union_anon_2_1) # idx == v))) else
  None.

Definition load_s_anon_5 (sz: Z) (ofs: Z) (st: s_anon_5) : option Z :=
  if (ofs =? 0) then Some (st.(e_cntp_ctl)) else
  if (ofs =? 8) then Some (st.(e_cntp_cval)) else
  if (ofs =? 16) then Some (st.(e_cntv_ctl)) else
  if (ofs =? 24) then Some (st.(e_cntv_cval)) else
  None.

Definition store_s_anon_5 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_5) : option s_anon_5 :=
  if (ofs =? 0) then Some (st.[e_cntp_ctl] :< v) else
  if (ofs =? 8) then Some (st.[e_cntp_cval] :< v) else
  if (ofs =? 16) then Some (st.[e_cntv_ctl] :< v) else
  if (ofs =? 24) then Some (st.[e_cntv_cval] :< v) else
  None.

Definition load_u_anon_4 (sz: Z) (ofs: Z) (st: u_anon_4) : option Z :=
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_5 sz elem_ofs (st.(e_union_anon_4_0))) else
  if (ofs >=? 1) && (ofs <? 225) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_4_1) @ idx)) else
  None.

Definition store_u_anon_4 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_4) : option u_anon_4 :=
  if (ofs >=? 0) && (ofs <? 32) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_5 sz elem_ofs v st.(e_union_anon_4_0);
    Some (st.[e_union_anon_4_0] :< ret)) else
  if (ofs >=? 1) && (ofs <? 225) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_4_1] :< (st.(e_union_anon_4_1) # idx == v))) else
  None.

Definition load_s_anon_7 (sz: Z) (ofs: Z) (st: s_anon_7) : option Z :=
  if (ofs =? 0) then Some (st.(e_ripas_base)) else
  if (ofs =? 8) then Some (st.(e_ripas_size)) else
  if (ofs =? 16) then Some (st.(e_ripas_value)) else
  None.

Definition store_s_anon_7 (sz: Z) (ofs: Z) (v: Z) (st: s_anon_7) : option s_anon_7 :=
  if (ofs =? 0) then Some (st.[e_ripas_base] :< v) else
  if (ofs =? 8) then Some (st.[e_ripas_size] :< v) else
  if (ofs =? 16) then Some (st.[e_ripas_value] :< v) else
  None.

Definition load_u_anon_6_9 (sz: Z) (ofs: Z) (st: u_anon_6_9) : option Z :=
  if (ofs >=? 0) && (ofs <? 24) then (
    let elem_ofs := ofs - 0 in
    load_s_anon_7 sz elem_ofs (st.(e_union_anon_6_9_0))) else
  if (ofs >=? 1) && (ofs <? 233) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_6_9_1) @ idx)) else
  None.

Definition store_u_anon_6_9 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_6_9) : option u_anon_6_9 :=
  if (ofs >=? 0) && (ofs <? 24) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_anon_7 sz elem_ofs v st.(e_union_anon_6_9_0);
    Some (st.[e_union_anon_6_9_0] :< ret)) else
  if (ofs >=? 1) && (ofs <? 233) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_6_9_1] :< (st.(e_union_anon_6_9_1) # idx == v))) else
  None.

Definition load_u_anon_8 (sz: Z) (ofs: Z) (st: u_anon_8) : option Z :=
  if (ofs =? 0) then Some (st.(e_union_anon_8_0)) else
  if (ofs >=? 1) && (ofs <? 253) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_8_1) @ idx)) else
  None.

Definition store_u_anon_8 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_8) : option u_anon_8 :=
  if (ofs =? 0) then Some (st.[e_union_anon_8_0] :< v) else
  if (ofs >=? 1) && (ofs <? 253) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_8_1] :< (st.(e_union_anon_8_1) # idx == v))) else
  None.

Definition load_u_anon_9 (sz: Z) (ofs: Z) (st: u_anon_9) : option Z :=
  if (ofs =? 0) then Some (st.(e_union_anon_9_0)) else
  None.

Definition store_u_anon_9 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_9) : option u_anon_9 :=
  if (ofs =? 0) then Some (st.[e_union_anon_9_0] :< v) else
  None.

Definition load_u_anon_11 (sz: Z) (ofs: Z) (st: u_anon_11) : option Z :=
  if (ofs =? 0) then Some (st.(e_union_anon_11_0)) else
  if (ofs >=? 1) && (ofs <? 233) then (
    let idx := (ofs - 1) / 1 in
    Some (st.(e_union_anon_11_1) @ idx)) else
  None.

Definition store_u_anon_11 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_11) : option u_anon_11 :=
  if (ofs =? 0) then Some (st.[e_union_anon_11_0] :< v) else
  if (ofs >=? 1) && (ofs <? 233) then (
    let idx := (ofs - 1) / 1 in
    Some (st.[e_union_anon_11_1] :< (st.(e_union_anon_11_1) # idx == v))) else
  None.

Definition load_s_rmi_rec_exit (sz: Z) (ofs: Z) (st: s_rmi_rec_exit) : option Z :=
  if (ofs >=? 0) && (ofs <? 256) then (
    let elem_ofs := ofs - 0 in
    load_u_anon_7 sz elem_ofs (st.(e_rmi_rec_exit_0))) else
  if (ofs >=? 256) && (ofs <? 512) then (
    let elem_ofs := ofs - 256 in
    load_u_anon_0 sz elem_ofs (st.(e_rmi_rec_exit_1))) else
  if (ofs >=? 512) && (ofs <? 768) then (
    let elem_ofs := ofs - 512 in
    load_u_anon_1 sz elem_ofs (st.(e_rmi_rec_exit_2))) else
  if (ofs >=? 768) && (ofs <? 1024) then (
    let elem_ofs := ofs - 768 in
    load_u_anon_2 sz elem_ofs (st.(e_rmi_rec_exit_3))) else
  if (ofs >=? 1024) && (ofs <? 1280) then (
    let elem_ofs := ofs - 1024 in
    load_u_anon_4 sz elem_ofs (st.(e_rmi_rec_exit_4))) else
  if (ofs >=? 1280) && (ofs <? 1536) then (
    let elem_ofs := ofs - 1280 in
    load_u_anon_6_9 sz elem_ofs (st.(e_rmi_rec_exit_5))) else
  if (ofs >=? 1536) && (ofs <? 1792) then (
    let elem_ofs := ofs - 1536 in
    load_u_anon_8 sz elem_ofs (st.(e_rmi_rec_exit_6))) else
  if (ofs >=? 1792) && (ofs <? 1800) then (
    let elem_ofs := ofs - 1792 in
    load_u_anon_9 sz elem_ofs (st.(e_rmi_rec_exit_7))) else
  if (ofs >=? 1800) && (ofs <? 1808) then (
    let elem_ofs := ofs - 1800 in
    load_u_anon_9 sz elem_ofs (st.(e_rmi_rec_exit_8))) else
  if (ofs >=? 1808) && (ofs <? 2048) then (
    let elem_ofs := ofs - 1808 in
    load_u_anon_11 sz elem_ofs (st.(e_rmi_rec_exit_9))) else
  None.

Definition store_s_rmi_rec_exit (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_rec_exit) : option s_rmi_rec_exit :=
  if (ofs >=? 0) && (ofs <? 256) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon_7 sz elem_ofs v st.(e_rmi_rec_exit_0);
    Some (st.[e_rmi_rec_exit_0] :< ret)) else
  if (ofs >=? 256) && (ofs <? 512) then (
    let elem_ofs := ofs - 256 in
    when ret == store_u_anon_0 sz elem_ofs v st.(e_rmi_rec_exit_1);
    Some (st.[e_rmi_rec_exit_1] :< ret)) else
  if (ofs >=? 512) && (ofs <? 768) then (
    let elem_ofs := ofs - 512 in
    when ret == store_u_anon_1 sz elem_ofs v st.(e_rmi_rec_exit_2);
    Some (st.[e_rmi_rec_exit_2] :< ret)) else
  if (ofs >=? 768) && (ofs <? 1024) then (
    let elem_ofs := ofs - 768 in
    when ret == store_u_anon_2 sz elem_ofs v st.(e_rmi_rec_exit_3);
    Some (st.[e_rmi_rec_exit_3] :< ret)) else
  if (ofs >=? 1024) && (ofs <? 1280) then (
    let elem_ofs := ofs - 1024 in
    when ret == store_u_anon_4 sz elem_ofs v st.(e_rmi_rec_exit_4);
    Some (st.[e_rmi_rec_exit_4] :< ret)) else
  if (ofs >=? 1280) && (ofs <? 1536) then (
    let elem_ofs := ofs - 1280 in
    when ret == store_u_anon_6_9 sz elem_ofs v st.(e_rmi_rec_exit_5);
    Some (st.[e_rmi_rec_exit_5] :< ret)) else
  if (ofs >=? 1536) && (ofs <? 1792) then (
    let elem_ofs := ofs - 1536 in
    when ret == store_u_anon_8 sz elem_ofs v st.(e_rmi_rec_exit_6);
    Some (st.[e_rmi_rec_exit_6] :< ret)) else
  if (ofs >=? 1792) && (ofs <? 1800) then (
    let elem_ofs := ofs - 1792 in
    when ret == store_u_anon_9 sz elem_ofs v st.(e_rmi_rec_exit_7);
    Some (st.[e_rmi_rec_exit_7] :< ret)) else
  if (ofs >=? 1800) && (ofs <? 1808) then (
    let elem_ofs := ofs - 1800 in
    when ret == store_u_anon_9 sz elem_ofs v st.(e_rmi_rec_exit_8);
    Some (st.[e_rmi_rec_exit_8] :< ret)) else
  if (ofs >=? 1808) && (ofs <? 2048) then (
    let elem_ofs := ofs - 1808 in
    when ret == store_u_anon_11 sz elem_ofs v st.(e_rmi_rec_exit_9);
    Some (st.[e_rmi_rec_exit_9] :< ret)) else
  None.

Definition load_u_anon_12_150 (sz: Z) (ofs: Z) (st: u_anon_12_150) : option Z :=
  if (ofs >=? 0) && (ofs <? 2048) then (
    let elem_ofs := ofs - 0 in
    load_s_rmi_rec_exit sz elem_ofs (st.(e_union_anon_12_150_0))) else
  None.

Definition store_u_anon_12_150 (sz: Z) (ofs: Z) (v: Z) (st: u_anon_12_150) : option u_anon_12_150 :=
  if (ofs >=? 0) && (ofs <? 2048) then (
    let elem_ofs := ofs - 0 in
    when ret == store_s_rmi_rec_exit sz elem_ofs v st.(e_union_anon_12_150_0);
    Some (st.[e_union_anon_12_150_0] :< ret)) else
  None.

Definition load_s_rmi_rec_run (sz: Z) (ofs: Z) (st: s_rmi_rec_run) : option Z :=
  if (ofs >=? 0) && (ofs <? 2048) then (
    let elem_ofs := ofs - 0 in
    load_u_anon_7_148 sz elem_ofs (st.(e_rmi_rec_run_0))) else
  if (ofs >=? 2048) && (ofs <? 4096) then (
    let elem_ofs := ofs - 2048 in
    load_u_anon_12_150 sz elem_ofs (st.(e_rmi_rec_run_1))) else
  None.

Definition store_s_rmi_rec_run (sz: Z) (ofs: Z) (v: Z) (st: s_rmi_rec_run) : option s_rmi_rec_run :=
  if (ofs >=? 0) && (ofs <? 2048) then (
    let elem_ofs := ofs - 0 in
    when ret == store_u_anon_7_148 sz elem_ofs v st.(e_rmi_rec_run_0);
    Some (st.[e_rmi_rec_run_0] :< ret)) else
  if (ofs >=? 2048) && (ofs <? 4096) then (
    let elem_ofs := ofs - 2048 in
    when ret == store_u_anon_12_150 sz elem_ofs v st.(e_rmi_rec_run_1);
    Some (st.[e_rmi_rec_run_1] :< ret)) else
  None.
