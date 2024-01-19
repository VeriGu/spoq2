Definition ns_buffer_read_spec (v_slot: Z) (v_ns_gr: Ptr) (v_offset: Z) (v_size: Z) (v_dest: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    (((((v_offset = (0)) /\ ((((v_ns_gr.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\ (((v_ns_gr.(pbase)) = ("granules")))) /\ ((v_slot = (0)))) /\
      ((((0 = (0)) /\ (((0 = (0)) /\ (("granules" = ("granules")))))) /\ ((((0 <= (24)) /\ ((0 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
  when v_call5, st_1 == ((memcpy_ns_read_spec_state_oracle v_dest (mkPtr "slot_ns" 0) v_size (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))).

Definition ns_buffer_write_spec (v_slot: Z) (v_ns_gr: Ptr) (v_offset: Z) (v_size: Z) (v_src: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    (((((v_offset = (0)) /\ ((((v_ns_gr.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\ (((v_ns_gr.(pbase)) = ("granules")))) /\ ((v_slot = (0)))) /\
      ((((0 = (0)) /\ (((0 = (0)) /\ (("granules" = ("granules")))))) /\ ((((0 <= (24)) /\ ((0 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
  when v_call5, st_1 == ((memcpy_ns_write_spec_state_oracle (mkPtr "slot_ns" 0) v_src v_size (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))).

Definition granule_memzero_spec (v_g: Ptr) (v_slot: Z) (st: RData) : (option RData) :=
  when v_call, st == ((granule_map_spec v_g v_slot st));
  when v_call1, st == ((memset_spec v_call 0 4096 st));
  when st == ((buffer_unmap_spec v_call st));
  let __return__ := true in
  (Some st).

Definition granule_memzero_mapped_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  when v_call, st == ((memset_spec v_buf 0 4096 st));
  let __return__ := true in
  (Some st).

