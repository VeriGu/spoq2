Definition simd_sve_get_max_vq_spec_mid (st: RData) : (option (Z * RData)) :=
  (Some (((st.(share)).(gv_g_sve_max_vq)), st)).

Definition simd_save_ns_state_spec_mid (st: RData) : (option RData) :=
  if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
  then (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (anno (((8784 + (0)) = (8784)));
    (anno ((((8832 * (CPU_ID)) + (8784)) = ((48 * (((184 * (CPU_ID)) + (183)))))));
    (anno (((8832 * (16)) = (141312)));
    (anno (((0 + (0)) = (0)));
    (anno (((141312 * (0)) = (0)));
    (anno (((48 * (((184 * (CPU_ID)) + (183)))) = ((8784 + ((8832 * (CPU_ID)))))));
    (anno (((0 + ((8784 + ((8832 * (CPU_ID)))))) = ((8784 + ((8832 * (CPU_ID)))))));
    (anno (((8784 + ((8832 * (CPU_ID)))) = ((48 * ((183 + ((184 * (CPU_ID)))))))));
    (anno (((48 * ((183 + ((184 * (CPU_ID)))))) = ((8784 + ((8832 * (CPU_ID)))))));
    when st'_0 == (
        (sve_config_vq_spec_state_oracle
          (st'.[share].[gv_g_ns_simd] :< (((st'.(share)).(gv_g_ns_simd)) # (8784 + ((8832 * (CPU_ID)))) == (((st'.(priv)).(pcpu_regs)).(pcpu_zcr_el2))))));
    when st'' == ((simd_save_state_spec_state_oracle st'_0));
    when st'_1 == ((simd_disable_spec_state_oracle st''));
    (anno (((8832 * (16)) = (141312)));
    (anno (((8792 + (0)) = (8792)));
    (anno (((141312 * (0)) = (0)));
    (anno ((((8832 * (CPU_ID)) + (8792)) = ((8 * (((1104 * (CPU_ID)) + (1099)))))));
    (anno (((8 * (((1104 * (CPU_ID)) + (1099)))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((0 + ((8792 + ((8832 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((8792 + ((8832 * (CPU_ID)))) = ((8 * ((1099 + ((1104 * (CPU_ID)))))))));
    (anno (((8 * ((1099 + ((1104 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 1)))))))))))))))))))))
  else (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (anno (((8832 * (16)) = (141312)));
    (anno (((0 + (0)) = (0)));
    (anno (((141312 * (0)) = (0)));
    when st'_0 == ((simd_save_state_spec_state_oracle st'));
    when st'_1 == ((simd_disable_spec_state_oracle st'_0));
    (anno (((8832 * (16)) = (141312)));
    (anno (((8792 + (0)) = (8792)));
    (anno (((141312 * (0)) = (0)));
    (anno ((((8832 * (CPU_ID)) + (8792)) = ((8 * (((1104 * (CPU_ID)) + (1099)))))));
    (anno (((8 * (((1104 * (CPU_ID)) + (1099)))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((0 + ((8792 + ((8832 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((8792 + ((8832 * (CPU_ID)))) = ((8 * ((1099 + ((1104 * (CPU_ID)))))))));
    (anno (((8 * ((1099 + ((1104 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 1))))))))))))))).

Definition simd_restore_ns_state_spec_mid (st: RData) : (option RData) :=
  if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
  then (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (anno (((8832 * (16)) = (141312)));
    (anno (((0 + (0)) = (0)));
    (anno (((141312 * (0)) = (0)));
    when st'_0 == ((sve_config_vq_spec_state_oracle st'));
    when st'' == ((simd_restore_state_spec_state_oracle st'_0));
    (anno (((8832 * (16)) = (141312)));
    (anno (((8784 + (0)) = (8784)));
    (anno (((141312 * (0)) = (0)));
    (anno ((((8832 * (CPU_ID)) + (8784)) = ((48 * (((184 * (CPU_ID)) + (183)))))));
    (anno (((48 * (((184 * (CPU_ID)) + (183)))) = ((8784 + ((8832 * (CPU_ID)))))));
    (anno (((0 + ((8784 + ((8832 * (CPU_ID)))))) = ((8784 + ((8832 * (CPU_ID)))))));
    (anno (((8784 + ((8832 * (CPU_ID)))) = ((48 * ((183 + ((184 * (CPU_ID)))))))));
    (anno (((48 * ((183 + ((184 * (CPU_ID)))))) = ((8784 + ((8832 * (CPU_ID)))))));
    when st'_1 == ((simd_disable_spec_state_oracle (st''.[priv].[pcpu_regs].[pcpu_zcr_el2] :< (((st''.(share)).(gv_g_ns_simd)) @ (8784 + ((8832 * (CPU_ID))))))));
    (anno (((8832 * (16)) = (141312)));
    (anno (((8792 + (0)) = (8792)));
    (anno (((141312 * (0)) = (0)));
    (anno ((((8832 * (CPU_ID)) + (8792)) = ((8 * (((1104 * (CPU_ID)) + (1099)))))));
    (anno (((8 * (((1104 * (CPU_ID)) + (1099)))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((0 + ((8792 + ((8832 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((8792 + ((8832 * (CPU_ID)))) = ((8 * ((1099 + ((1104 * (CPU_ID)))))))));
    (anno (((8 * ((1099 + ((1104 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 0)))))))))))))))))))))))
  else (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    (anno (((8832 * (16)) = (141312)));
    (anno (((0 + (0)) = (0)));
    (anno (((141312 * (0)) = (0)));
    when st'_0 == ((simd_restore_state_spec_state_oracle st'));
    when st'_1 == ((simd_disable_spec_state_oracle st'_0));
    (anno (((8832 * (16)) = (141312)));
    (anno (((8792 + (0)) = (8792)));
    (anno (((141312 * (0)) = (0)));
    (anno ((((8832 * (CPU_ID)) + (8792)) = ((8 * (((1104 * (CPU_ID)) + (1099)))))));
    (anno (((8 * (((1104 * (CPU_ID)) + (1099)))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((0 + ((8792 + ((8832 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (anno (((8792 + ((8832 * (CPU_ID)))) = ((8 * ((1099 + ((1104 * (CPU_ID)))))))));
    (anno (((8 * ((1099 + ((1104 * (CPU_ID)))))) = ((8792 + ((8832 * (CPU_ID)))))));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 0))))))))))))))).

Definition rec_simd_enable_restore_spec_mid (v_rec: Ptr) (st: RData) : (option RData) :=
  rely ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)));
  rely ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)));
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  when ret == ((rec_simd_type_spec' v_rec st));
  when st' == ((simd_enable_spec_state_oracle st));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((16 + (0)) = (16)));
  (anno (((1096 + (16)) = (1112)));
  (anno (((0 + (1112)) = (1112)));
  rely (
    match (((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)) = (22)));
  rely (
    (((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
      ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
        (SLOT_REC_AUX0)) >=
        (0)))) /\
      ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
        (22)) <
        (0)))));
  (anno (((GRANULE_SIZE * (MAX_REC_AUX_GRANULES)) = (65536)));
  rely (
    ((("slot_rec_aux0" = ("slot_rec_aux0")) /\
      (((16384 - ((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
        (0)))) \/
      (("slot_rec_aux0" = ("g_ns_simd")))));
  if (ret =? (2))
  then (
    rely (
      match (((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    when st'_0 == ((sve_config_vq_spec_state_oracle st'));
    rely (
      match (((((st'_0.(share)).(granules)) @ ((((st'_0.(share)).(granule_data)) @ (((st'_0.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st'_0.(share)).(granules)) @ ((((st'_0.(share)).(granule_data)) @ (((st'_0.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'_0.(share)).(granules)) @ ((((st'_0.(share)).(granule_data)) @ (((st'_0.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    when st'' == ((simd_restore_state_spec_state_oracle st'_0));
    (anno (((3272 * (0)) = (0)));
    (anno (((8 + (0)) = (8)));
    (anno (((16 + (8)) = (24)));
    (anno (((1096 + (24)) = (1120)));
    (anno (((0 + (1120)) = (1120)));
    rely (
      match (((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st''.[share].[granule_data] :<
      (((st''.(share)).(granule_data)) #
        (((st''.(share)).(slots)) @ SLOT_REC) ==
        ((((st''.(share)).(granule_data)) @ (((st''.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_aux_data].[e_rec_simd].[e_simd_allowed] :< 1))))))))))
  else (
    rely (
      match (((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    when st'_0 == ((simd_restore_state_spec_state_oracle st'));
    (anno (((3272 * (0)) = (0)));
    (anno (((8 + (0)) = (8)));
    (anno (((16 + (8)) = (24)));
    (anno (((1096 + (24)) = (1120)));
    (anno (((0 + (1120)) = (1120)));
    rely (
      match (((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st'_0.[share].[granule_data] :<
      (((st'_0.(share)).(granule_data)) #
        (((st'_0.(share)).(slots)) @ SLOT_REC) ==
        ((((st'_0.(share)).(granule_data)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_aux_data].[e_rec_simd].[e_simd_allowed] :< 1))))))))))))))))).

Definition simd_state_init_spec_mid (v_type: Z) (v_simd: Ptr) (v_sve_vq: Z) (st: RData) : (option RData) :=
  (anno (((REC_HEAP_SIZE + (REC_PMU_SIZE)) = (16384)));
  rely ((((v_simd.(pbase)) = ("slot_rec_aux0")) /\ (((16384 - ((v_simd.(poffset)))) = (0)))));
  if (v_type =? (2))
  then (
    (anno (((8784 * (0)) = (0)));
    (anno (((1 * (8232)) = (8232)));
    (anno (((8232 + (0)) = (8232)));
    (anno (((1 + (8232)) = (8233)));
    (anno (((0 + (8233)) = (8233)));
    rely (
      match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    (anno (((8784 * (0)) = (0)));
    (anno (((8768 + (0)) = (8768)));
    (anno (((0 + (8768)) = (8768)));
    (anno (((((v_simd.(poffset)) + (8233)) - (REC_HEAP_SIZE)) = ((41 + ((v_simd.(poffset)))))));
    (anno ((((41 + ((v_simd.(poffset)))) - (REC_PMU_SIZE)) = (((- 8151) + ((v_simd.(poffset)))))));
    (anno (((((- 8151) + ((v_simd.(poffset)))) - (0)) = (((- 8151) + ((v_simd.(poffset)))))));
    (anno (((((- 8151) + ((v_simd.(poffset)))) - (528)) = (((- 8679) + ((v_simd.(poffset)))))));
    (anno (((((- 8679) + ((v_simd.(poffset)))) / (1)) = (((- 8679) + ((v_simd.(poffset)))))));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state] :<
          ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(g_aux_simd_state)).[e_simd_type] :< v_type).[e_t].[e_padding0] :<
            (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(g_aux_simd_state)).(e_t)).(e_padding0)) #
              ((- 8679) + ((v_simd.(poffset)))) ==
              v_sve_vq))))))))))))))))))))
  else (
    (anno (((8784 * (0)) = (0)));
    (anno (((8768 + (0)) = (8768)));
    (anno (((0 + (8768)) = (8768)));
    rely (
      match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< v_type))))))))).

