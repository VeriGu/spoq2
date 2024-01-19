Parameter simd_save_ns_state_spec_state_oracle : RData -> (option RData).

Parameter simd_restore_ns_state_spec_state_oracle : RData -> (option RData).

Parameter rec_simd_enable_restore_spec_state_oracle : RData -> (option RData).

Parameter simd_state_init_spec_state_oracle : RData -> (option RData).

Definition simd_sve_get_max_vq_spec (st: RData) : (option (Z * RData)) :=
  (Some (((st.(share)).(gv_g_sve_max_vq)), st)).

Definition simd_save_ns_state_spec_shadow (st: RData) : (option RData) :=
  if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
  then (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == (
        (sve_config_vq_spec_state_oracle
          (st'.[share].[gv_g_ns_simd] :< (((st'.(share)).(gv_g_ns_simd)) # (8784 + ((8832 * (CPU_ID)))) == (((st'.(priv)).(pcpu_regs)).(pcpu_zcr_el2))))));
    when st'' == ((simd_save_state_spec_state_oracle st'_0));
    when st'_1 == ((simd_disable_spec_state_oracle st''));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 1))))
  else (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((simd_save_state_spec_state_oracle st'));
    when st'_1 == ((simd_disable_spec_state_oracle st'_0));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 1)))).

Definition simd_save_ns_state_spec (st: RData) : (option RData) :=
  if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
  then (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((sve_config_vq_spec_state_oracle st'));
    when st'' == ((simd_save_state_spec_state_oracle st'_0));
    when st'_1 == ((simd_disable_spec_state_oracle st''));
    when st'_1' == ((simd_save_ns_state_spec_state_oracle st'_1));
    (Some st'_1'))
  else (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((simd_save_state_spec_state_oracle st'));
    when st'_1 == ((simd_disable_spec_state_oracle st'_0));
    when st'_1' == ((simd_save_ns_state_spec_state_oracle st'_1));
    (Some st'_1')).

Definition simd_restore_ns_state_spec_shadow (st: RData) : (option RData) :=
  if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
  then (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((sve_config_vq_spec_state_oracle st'));
    when st'' == ((simd_restore_state_spec_state_oracle st'_0));
    when st'_1 == ((simd_disable_spec_state_oracle (st''.[priv].[pcpu_regs].[pcpu_zcr_el2] :< (((st''.(share)).(gv_g_ns_simd)) @ (8784 + ((8832 * (CPU_ID))))))));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 0))))
  else (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((simd_restore_state_spec_state_oracle st'));
    when st'_1 == ((simd_disable_spec_state_oracle st'_0));
    (Some (st'_1.[share].[gv_g_ns_simd] :< (((st'_1.(share)).(gv_g_ns_simd)) # (8792 + ((8832 * (CPU_ID)))) == 0)))).

Definition simd_restore_ns_state_spec (st: RData) : (option RData) :=
  if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
  then (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((sve_config_vq_spec_state_oracle st'));
    when st'' == ((simd_restore_state_spec_state_oracle st'_0));
    when st'_1 == ((simd_disable_spec_state_oracle st''));
    when st'_1' == ((simd_restore_ns_state_spec_state_oracle st'_1));
    (Some st'_1'))
  else (
    when st' == ((simd_enable_spec_state_oracle st));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    when st'_0 == ((simd_restore_state_spec_state_oracle st'));
    when st'_1 == ((simd_disable_spec_state_oracle st'_0));
    when st'_1' == ((simd_restore_ns_state_spec_state_oracle st'_1));
    (Some st'_1')).

Definition rec_simd_enable_restore_spec_shadow (v_rec: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)) /\
      ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when ret == ((rec_simd_type_spec' v_rec st));
  when st' == ((simd_enable_spec_state_oracle st));
  rely (
    (((match (((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end) /\
      ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
        ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
          (SLOT_REC_AUX0)) >=
          (0)))) /\
        ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
          (22)) <
          (0)))))) /\
      (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
        (((16384 - ((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
          (0)))) \/
        (("slot_rec_aux0" = ("g_ns_simd")))))));
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
    rely (
      match (((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st''.[share].[granule_data] :<
      (((st''.(share)).(granule_data)) #
        (((st''.(share)).(slots)) @ SLOT_REC) ==
        ((((st''.(share)).(granule_data)) @ (((st''.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_aux_data].[e_rec_simd].[e_simd_allowed] :< 1)))))
  else (
    rely (
      match (((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    when st'_0 == ((simd_restore_state_spec_state_oracle st'));
    rely (
      match (((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st'_0.[share].[granule_data] :<
      (((st'_0.(share)).(granule_data)) #
        (((st'_0.(share)).(slots)) @ SLOT_REC) ==
        ((((st'_0.(share)).(granule_data)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_aux_data].[e_rec_simd].[e_simd_allowed] :< 1))))).

Definition rec_simd_enable_restore_spec (v_rec: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)) /\
      ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when ret == ((rec_simd_type_spec' v_rec st));
  when st' == ((simd_enable_spec_state_oracle st));
  rely (
    match (((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
        ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
          ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
            (SLOT_REC_AUX0)) >=
            (0)))) /\
          ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
            (22)) <
            (0)))))) /\
        (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
          (((16384 - ((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
            (0)))) \/
          (("slot_rec_aux0" = ("g_ns_simd"))))))
    | None =>
      ((((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
        ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
          ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
            (SLOT_REC_AUX0)) >=
            (0)))) /\
          ((((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
            (22)) <
            (0)))))) /\
        (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
          (((16384 - ((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
            (0)))) \/
          (("slot_rec_aux0" = ("g_ns_simd"))))))
    end);
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
    rely (
      match (((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    when st''' == ((rec_simd_enable_restore_spec_state_oracle st''));
    (Some st'''))
  else (
    rely (
      match (((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'.(share)).(granules)) @ ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    when st'_0 == ((simd_restore_state_spec_state_oracle st'));
    rely (
      match (((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st'_0.(share)).(granules)) @ (((st'_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end);
    when st'_0' == ((rec_simd_enable_restore_spec_state_oracle st'_0));
    (Some st'_0')).

Definition simd_state_init_spec_shadow (v_type: Z) (v_simd: Ptr) (v_sve_vq: Z) (st: RData) : (option RData) :=
  rely ((((v_simd.(pbase)) = ("slot_rec_aux0")) /\ (((16384 - ((v_simd.(poffset)))) = (0)))));
  if (v_type =? (2))
  then (
    rely (
      match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state] :<
          ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(g_aux_simd_state)).[e_simd_type] :< v_type).[e_t].[e_padding0] :<
            (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(g_aux_simd_state)).(e_t)).(e_padding0)) #
              ((- 8679) + ((v_simd.(poffset)))) ==
              v_sve_vq)))))))
  else (
    rely (
      match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end);
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_REC_AUX0) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).[g_aux_simd_state].[e_simd_type] :< v_type))))).

Definition simd_state_init_spec (v_type: Z) (v_simd: Ptr) (v_sve_vq: Z) (st: RData) : (option RData) :=
  rely (
    ((((v_simd.(pbase)) = ("slot_rec_aux0")) /\ (((16384 - ((v_simd.(poffset)))) = (0)))) /\
      (match (((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
      end)));
  when st' == ((simd_state_init_spec_state_oracle st));
  (Some st').

