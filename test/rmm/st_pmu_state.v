Record s_pmev_regs :=
 mks_pmev_regs {
    e_pmevcntr_el0 : Z;
    e_pmevtyper_el0 : Z
  }.

Record s_pmu_state :=
 mks_pmu_state {
    e_pmccfiltr_el0 : Z;
    e_pmccntr_el0 : Z;
    e_pmcntenset_el0 : Z;
    e_pmcntenclr_el0 : Z;
    e_pmintenset_el1 : Z;
    e_pmintenclr_el1 : Z;
    e_pmovsset_el0 : Z;
    e_pmovsclr_el0 : Z;
    e_pmselr_el0 : Z;
    e_pmuserenr_el0 : Z;
    e_pmxevcntr_el0 : Z;
    e_pmxevtyper_el0 : Z;
    e_pmev_regs : (ZMap.t s_pmev_regs)
  }.

Definition load_s_pmev_regs (sz: Z) (ofs: Z) (st: s_pmev_regs) : option Z :=
  if (ofs =? 0) then Some (st.(e_pmevcntr_el0)) else
  if (ofs =? 8) then Some (st.(e_pmevtyper_el0)) else
  None.

Definition store_s_pmev_regs (sz: Z) (ofs: Z) (v: Z) (st: s_pmev_regs) : option s_pmev_regs :=
  if (ofs =? 0) then Some (st.[e_pmevcntr_el0] :< v) else
  if (ofs =? 8) then Some (st.[e_pmevtyper_el0] :< v) else
  None.

Definition load_s_pmu_state (sz: Z) (ofs: Z) (st: s_pmu_state) : option Z :=
  if (ofs =? 0) then Some (st.(e_pmccfiltr_el0)) else
  if (ofs =? 8) then Some (st.(e_pmccntr_el0)) else
  if (ofs =? 16) then Some (st.(e_pmcntenset_el0)) else
  if (ofs =? 24) then Some (st.(e_pmcntenclr_el0)) else
  if (ofs =? 32) then Some (st.(e_pmintenset_el1)) else
  if (ofs =? 40) then Some (st.(e_pmintenclr_el1)) else
  if (ofs =? 48) then Some (st.(e_pmovsset_el0)) else
  if (ofs =? 56) then Some (st.(e_pmovsclr_el0)) else
  if (ofs =? 64) then Some (st.(e_pmselr_el0)) else
  if (ofs =? 72) then Some (st.(e_pmuserenr_el0)) else
  if (ofs =? 80) then Some (st.(e_pmxevcntr_el0)) else
  if (ofs =? 88) then Some (st.(e_pmxevtyper_el0)) else
  if (ofs >=? 96) && (ofs <? 592) then (
    let idx := (ofs - 96) / 16 in
    let elem_ofs := (ofs - 96) mod 16 in
    load_s_pmev_regs sz elem_ofs (st.(e_pmev_regs) @ idx)) else
  None.

Definition store_s_pmu_state (sz: Z) (ofs: Z) (v: Z) (st: s_pmu_state) : option s_pmu_state :=
  if (ofs =? 0) then Some (st.[e_pmccfiltr_el0] :< v) else
  if (ofs =? 8) then Some (st.[e_pmccntr_el0] :< v) else
  if (ofs =? 16) then Some (st.[e_pmcntenset_el0] :< v) else
  if (ofs =? 24) then Some (st.[e_pmcntenclr_el0] :< v) else
  if (ofs =? 32) then Some (st.[e_pmintenset_el1] :< v) else
  if (ofs =? 40) then Some (st.[e_pmintenclr_el1] :< v) else
  if (ofs =? 48) then Some (st.[e_pmovsset_el0] :< v) else
  if (ofs =? 56) then Some (st.[e_pmovsclr_el0] :< v) else
  if (ofs =? 64) then Some (st.[e_pmselr_el0] :< v) else
  if (ofs =? 72) then Some (st.[e_pmuserenr_el0] :< v) else
  if (ofs =? 80) then Some (st.[e_pmxevcntr_el0] :< v) else
  if (ofs =? 88) then Some (st.[e_pmxevtyper_el0] :< v) else
  if (ofs >=? 96) && (ofs <? 592) then (
    let idx := (ofs - 96) / 16 in
    let elem_ofs := (ofs - 96) mod 16 in
    when ret == store_s_pmev_regs sz elem_ofs v (st.(e_pmev_regs) @ idx);
    Some (st.[e_pmev_regs] :< (st.(e_pmev_regs) # idx == ret))) else
  None.

