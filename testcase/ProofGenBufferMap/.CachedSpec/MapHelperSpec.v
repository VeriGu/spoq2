Definition xlat_unmap_memory_page_spec (v_table: Ptr) (v_va: Z) (st: RData) : (option (Z * RData)) :=
  let v_ptr := (int_to_ptr v_va) in
  match (((v_ptr.(pbase)), (v_ptr.(poffset)))) with
  | ("slot_ns", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (- 1)))))
  | ("slot_rd", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (- 1)))))
  | ("slot_rec", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == (- 1)))))
  | ("slot_rec2", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == (- 1)))))
  | ("slot_rec_target", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == (- 1)))))
  | ("slot_rec_aux0", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == (- 1)))))
  | ("slot_rtt", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1)))))
  | ("slot_rtt2", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == (- 1)))))
  | ("slot_rsi_call", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == (- 1)))))
  | _ => None
  end.

Definition xlat_map_memory_page_with_attrs_spec (v_table: Ptr) (v_va: Z) (v_pa: Z) (v_attrs: Z) (st: RData) : (option (Z * RData)) :=
  let v_ptr := (int_to_ptr v_va) in
  let gidx := (v_pa / (GRANULE_SIZE)) in
  let g := (((st.(share)).(granules)) @ gidx) in
  match (((v_ptr.(pbase)), (v_ptr.(poffset)))) with
  | ("slot_ns", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == gidx))))
  | ("slot_rd", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == gidx))))
  | ("slot_rec", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == gidx))))
  | ("slot_rec2", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == gidx))))
  | ("slot_rec_target", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == gidx))))
  | ("slot_rec_aux0", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == gidx))))
  | ("slot_rtt", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == gidx))))
  | ("slot_rtt2", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == gidx))))
  | ("slot_rsi_call", ofs) => (Some (0, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == gidx))))
  | _ => None
  end.

