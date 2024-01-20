  Definition rec_simd_enable_restore_spec_low (v_rec: Ptr) (st: RData) : (option RData) :=
    rely ((rec_aux_refcount_one st));
    rely ((rec_aux_is_unlocked st));
    rely ((rec_refcount_one st));
    rely ((rec_is_unlocked st));
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    when v_call, st == ((rec_simd_type_spec v_rec st));
    when st == ((simd_enable_spec v_call st));
    let v_simd := (ptr_offset v_rec ((3272 * (0)) + ((1096 + ((16 + ((0 + (0))))))))) in
    when v_0_tmp, st == ((load_RData 8 v_simd st));
    let slot := (v_0_tmp - SLOT_VIRT) / GRANULE_SIZE in
    rely ((v_0_tmp < GRANULES_BASE) /\ (((v_0_tmp - SLOT_VIRT) / GRANULE_SIZE) >= SLOT_REC_AUX0) /\ (((v_0_tmp - SLOT_VIRT) / GRANULE_SIZE) < SLOT_REC_AUX0 + MAX_REC_AUX_GRANULES));
    let v_0 := (int_to_ptr v_0_tmp) in
    when st == ((simd_restore_state_spec v_call v_0 st));
    let v_simd_allowed := (ptr_offset v_rec ((3272 * (0)) + ((1096 + ((16 + ((8 + (0))))))))) in
    when st == ((store_RData 1 v_simd_allowed 1 st));
    let __return__ := true in
    (Some st).

  Definition simd_restore_ns_state_spec_low (st: RData) : (option RData) :=
    when v_call, st == ((my_cpuid_spec st));
    when v__b_tmp, st == ((load_RData 1 (mkPtr "g_cpu_simd_type" 0) st));
    let v__b := (v__b_tmp <>? (0)) in
    let v_0 := (
        if v__b
        then 2
        else 1) in
    when st == ((simd_enable_spec v_0 st));
    let v_idxprom := v_call in
    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (16)))));
    let v_simd := (ptr_offset (mkPtr "g_ns_simd" 0) (((8832 * (16)) * (0)) + (((8832 * (v_idxprom)) + ((0 + (0))))))) in
    when st == ((simd_restore_state_spec v_0 v_simd st));
    when st == (
        if v__b
        then (
          rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (16)))));
          let v_ns_zcr_el2 := (ptr_offset (mkPtr "g_ns_simd" 0) (((8832 * (16)) * (0)) + (((8832 * (v_idxprom)) + ((8784 + (0))))))) in
          when v_1, st == ((load_RData 8 v_ns_zcr_el2 st));
          when st == ((write_zcr_el2_spec v_1 st));
          when st == ((isb_spec st));
          (Some st))
        else (Some st));
    when st == ((simd_disable_spec st));
    rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (16)))));
    let v_saved := (ptr_offset (mkPtr "g_ns_simd" 0) (((8832 * (16)) * (0)) + (((8832 * (v_idxprom)) + ((8792 + (0))))))) in
    when st == ((store_RData 1 v_saved 0 st));
    let __return__ := true in
    (Some st).

  Definition simd_save_ns_state_spec_low (st: RData) : (option RData) :=
    when v_call, st == ((my_cpuid_spec st));
    when v__b_tmp, st == ((load_RData 1 (mkPtr "g_cpu_simd_type" 0) st));
    let v__b := (v__b_tmp <>? (0)) in
    let v_0 := (
        if v__b
        then 2
        else 1) in
    when st == ((simd_enable_spec v_0 st));
    when st == (
        if v__b
        then (
          when v_call1, st == ((read_zcr_el2_spec st));
          let v_idxprom := v_call in
          rely (((0 <= (v_idxprom)) /\ ((v_idxprom < (16)))));
          let v_ns_zcr_el2 := (ptr_offset (mkPtr "g_ns_simd" 0) (((8832 * (16)) * (0)) + (((8832 * (v_idxprom)) + ((8784 + (0))))))) in
          when st == ((store_RData 8 v_ns_zcr_el2 v_call1 st));
          (Some st))
        else (Some st));
    let v_idxprom2 := v_call in
    rely (((0 <= (v_idxprom2)) /\ ((v_idxprom2 < (16)))));
    let v_simd := (ptr_offset (mkPtr "g_ns_simd" 0) (((8832 * (16)) * (0)) + (((8832 * (v_idxprom2)) + ((0 + (0))))))) in
    when st == ((simd_save_state_spec v_0 v_simd st));
    when st == ((simd_disable_spec st));
    rely (((0 <= (v_idxprom2)) /\ ((v_idxprom2 < (16)))));
    let v_saved := (ptr_offset (mkPtr "g_ns_simd" 0) (((8832 * (16)) * (0)) + (((8832 * (v_idxprom2)) + ((8792 + (0))))))) in
    when st == ((store_RData 1 v_saved 1 st));
    let __return__ := true in
    (Some st).

  Definition simd_state_init_spec_low (v_type: Z) (v_simd: Ptr) (v_sve_vq: Z) (st: RData) : (option RData) :=
    rely ((((v_simd.(pbase)) = ("slot_rec_aux0")) /\ (((REC_HEAP_SIZE + (REC_PMU_SIZE)) = ((v_simd.(poffset)))))));
    let v_cmp := (v_type =? (2)) in
    when st == (
        if v_cmp
        then (
          rely (((0 <= (8232)) /\ ((8232 < (8240)))));
          let v_0 := (ptr_offset v_simd ((8784 * (0)) + ((0 + ((1 + (((1 * (8232)) + (0))))))))) in
          when st == ((store_RData 1 v_0 v_sve_vq st));
          (Some st))
        else (Some st));
    let v_simd_type := (ptr_offset v_simd ((8784 * (0)) + ((8768 + (0))))) in
    when st == ((store_RData 4 v_simd_type v_type st));
    let __return__ := true in
    (Some st).


  Definition simd_sve_get_max_vq_spec_low (st: RData) : (option (Z * RData)) :=
    when v_0, st == ((load_RData 4 (mkPtr "g_sve_max_vq" 0) st));
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

