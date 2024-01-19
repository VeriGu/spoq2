Definition simd_save_state_spec_mid (v_type: Z) (v_simd: Ptr) (st: RData) : (option RData) :=
  (anno (((REC_HEAP_SIZE + (REC_PMU_SIZE)) = (16384)));
  rely (((((v_simd.(pbase)) = ("slot_rec_aux0")) /\ (((16384 - ((v_simd.(poffset)))) = (0)))) \/ (((v_simd.(pbase)) = ("g_ns_simd")))));
  if (v_type =? (2))
  then (
    (anno (((8784 * (0)) = (0)));
    (anno (((1 * (8232)) = (8232)));
    (anno (((8232 + (0)) = (8232)));
    (anno (((1 + (8232)) = (8233)));
    (anno (((0 + (8233)) = (8233)));
    if ((v_simd.(pbase)) =s ("slot_rec_aux0"))
    then (
      rely (
        match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
        | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
        | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
        end);
      when st' == ((sve_config_vq_spec_state_oracle st));
      (anno (((1 * (7664)) = (7664)));
      (anno (((7664 + (0)) = (7664)));
      (anno (((1 + (7664)) = (7665)));
      (anno (((0 + (7665)) = (7665)));
      (anno (((1 * (8208)) = (8208)));
      (anno (((8208 + (0)) = (8208)));
      (anno (((1 + (8208)) = (8209)));
      (anno (((0 + (8209)) = (8209)));
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      rely (
        match (((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
        | (Some cid) => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
        | None => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
        end);
      (Some (st'.[share].[granule_data] :<
        (((st'.(share)).(granule_data)) #
          (((st'.(share)).(slots)) @ SLOT_REC_AUX0) ==
          ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< v_type))))))))))))))))
    else (
      when st' == ((sve_config_vq_spec_state_oracle st));
      (anno (((1 * (7664)) = (7664)));
      (anno (((7664 + (0)) = (7664)));
      (anno (((1 + (7664)) = (7665)));
      (anno (((0 + (7665)) = (7665)));
      (anno (((1 * (8208)) = (8208)));
      (anno (((8208 + (0)) = (8208)));
      (anno (((1 + (8208)) = (8209)));
      (anno (((0 + (8209)) = (8209)));
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      (Some (st'.[share].[gv_g_ns_simd] :< (((st'.(share)).(gv_g_ns_simd)) # ((v_simd.(poffset)) + (8768)) == v_type)))))))))))))))))))))
  else (
    if (v_type =? (1))
    then (
      (anno (((0 + (0)) = (0)));
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      if ((v_simd.(pbase)) =s ("slot_rec_aux0"))
      then (
        rely (
          match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        (Some (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< v_type)))))
      else (Some (st.[share].[gv_g_ns_simd] :< (((st.(share)).(gv_g_ns_simd)) # ((v_simd.(poffset)) + (8768)) == v_type))))))))
    else (
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      if ((v_simd.(pbase)) =s ("slot_rec_aux0"))
      then (
        rely (
          match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        (Some (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< v_type)))))
      else (Some (st.[share].[gv_g_ns_simd] :< (((st.(share)).(gv_g_ns_simd)) # ((v_simd.(poffset)) + (8768)) == v_type))))))))).

Definition simd_restore_state_spec_mid (v_type: Z) (v_simd: Ptr) (st: RData) : (option RData) :=
  (anno (((REC_HEAP_SIZE + (REC_PMU_SIZE)) = (16384)));
  rely (((((v_simd.(pbase)) = ("slot_rec_aux0")) /\ (((16384 - ((v_simd.(poffset)))) = (0)))) \/ (((v_simd.(pbase)) = ("g_ns_simd")))));
  if (v_type =? (2))
  then (
    (anno (((8784 * (0)) = (0)));
    (anno (((1 * (8232)) = (8232)));
    (anno (((8232 + (0)) = (8232)));
    (anno (((1 + (8232)) = (8233)));
    (anno (((0 + (8233)) = (8233)));
    if ((v_simd.(pbase)) =s ("slot_rec_aux0"))
    then (
      rely (
        match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
        | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
        | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
        end);
      when st' == ((sve_config_vq_spec_state_oracle st));
      (anno (((1 * (7664)) = (7664)));
      (anno (((7664 + (0)) = (7664)));
      (anno (((1 + (7664)) = (7665)));
      (anno (((0 + (7665)) = (7665)));
      (anno (((1 * (8208)) = (8208)));
      (anno (((8208 + (0)) = (8208)));
      (anno (((1 + (8208)) = (8209)));
      (anno (((0 + (8209)) = (8209)));
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      rely (
        match (((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
        | (Some cid) => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
        | None => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
        end);
      (Some (st'.[share].[granule_data] :<
        (((st'.(share)).(granule_data)) #
          (((st'.(share)).(slots)) @ SLOT_REC_AUX0) ==
          ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< 0))))))))))))))))
    else (
      when st' == ((sve_config_vq_spec_state_oracle st));
      (anno (((1 * (7664)) = (7664)));
      (anno (((7664 + (0)) = (7664)));
      (anno (((1 + (7664)) = (7665)));
      (anno (((0 + (7665)) = (7665)));
      (anno (((1 * (8208)) = (8208)));
      (anno (((8208 + (0)) = (8208)));
      (anno (((1 + (8208)) = (8209)));
      (anno (((0 + (8209)) = (8209)));
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      (Some (st'.[share].[gv_g_ns_simd] :< (((st'.(share)).(gv_g_ns_simd)) # ((v_simd.(poffset)) + (8768)) == 0)))))))))))))))))))))
  else (
    if (v_type =? (1))
    then (
      (anno (((0 + (0)) = (0)));
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      if ((v_simd.(pbase)) =s ("slot_rec_aux0"))
      then (
        rely (
          match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        (Some (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< 0)))))
      else (Some (st.[share].[gv_g_ns_simd] :< (((st.(share)).(gv_g_ns_simd)) # ((v_simd.(poffset)) + (8768)) == 0))))))))
    else (
      (anno (((8784 * (0)) = (0)));
      (anno (((8768 + (0)) = (8768)));
      (anno (((0 + (8768)) = (8768)));
      if ((v_simd.(pbase)) =s ("slot_rec_aux0"))
      then (
        rely (
          match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        (Some (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< 0)))))
      else (Some (st.[share].[gv_g_ns_simd] :< (((st.(share)).(gv_g_ns_simd)) # ((v_simd.(poffset)) + (8768)) == 0))))))))).

Definition simd_disable_spec_mid (st: RData) : (option RData) :=
  (Some (st.[priv].[pcpu_regs].[pcpu_cptr_el2] :< ((((st.(priv)).(pcpu_regs)).(pcpu_cptr_el2)) & (18446744073706209279)))).

Definition simd_enable_spec_mid (v_type: Z) (st: RData) : (option RData) :=
  if (v_type =? (1))
  then (Some (st.[priv].[pcpu_regs].[pcpu_cptr_el2] :< (((((st.(priv)).(pcpu_regs)).(pcpu_cptr_el2)) & (18446744073706209279)) |' (3145728))))
  else (
    if (v_type =? (2))
    then (Some (st.[priv].[pcpu_regs].[pcpu_cptr_el2] :< ((((st.(priv)).(pcpu_regs)).(pcpu_cptr_el2)) |' (3342336))))
    else (Some (st.[priv].[pcpu_regs].[pcpu_cptr_el2] :< ((((st.(priv)).(pcpu_regs)).(pcpu_cptr_el2)) & (18446744073706209279))))).

