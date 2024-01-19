Definition handle_simd_exception_spec_mid (v_exp_type: Z) (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
  if (v_exp_type =? (2))
  then (
    when ret == ((rec_simd_type_spec' v_rec st));
    if (ret =? (2))
    then (
      if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
      then (
        when st' == ((simd_enable_spec_state_oracle st));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when st'_0 == ((sve_config_vq_spec_state_oracle st'));
        when st'' == ((simd_save_state_spec_state_oracle st'_0));
        when st'_1 == ((simd_disable_spec_state_oracle st''));
        when st'_1' == ((simd_save_ns_state_spec_state_oracle st'_1));
        rely (
          (((((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)) /\
            ((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)))) /\
            ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)))) /\
            ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
            ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
        when ret_0 == ((rec_simd_type_spec' v_rec st'_1'));
        when st'_2 == ((simd_enable_spec_state_oracle st'_1'));
        rely (
          match (((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) =>
            ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (SLOT_REC_AUX0)) >=
                  (0)))) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (22)) <
                  (0)))))) /\
              (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
                (((16384 -
                  ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                  (0)))) \/
                (("slot_rec_aux0" = ("g_ns_simd"))))))
          | None =>
            ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (SLOT_REC_AUX0)) >=
                  (0)))) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (22)) <
                  (0)))))) /\
              (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
                (((16384 -
                  ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                  (0)))) \/
                (("slot_rec_aux0" = ("g_ns_simd"))))))
          end);
        if (ret_0 =? (2))
        then (
          rely (
            match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
            | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
            end);
          when st'_3 == ((sve_config_vq_spec_state_oracle st'_2));
          rely (
            match (((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
            | (Some cid) => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
            end);
          when st''_0 == ((simd_restore_state_spec_state_oracle st'_3));
          rely (
            match (((((st''_0.(share)).(granules)) @ (((st''_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
            | (Some cid) => ((((((st''_0.(share)).(granules)) @ (((st''_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
            | None => ((((((st''_0.(share)).(granules)) @ (((st''_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
            end);
          when st''' == ((rec_simd_enable_restore_spec_state_oracle st''_0));
          (Some (false, st''')))
        else (
          rely (
            match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
            | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
            end);
          when st'_3 == ((simd_restore_state_spec_state_oracle st'_2));
          rely (
            match (((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
            | (Some cid) => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
            end);
          when st'_0' == ((rec_simd_enable_restore_spec_state_oracle st'_3));
          (Some (false, st'_0'))))
      else (
        when st' == ((simd_enable_spec_state_oracle st));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when st'_0 == ((simd_save_state_spec_state_oracle st'));
        when st'_1 == ((simd_disable_spec_state_oracle st'_0));
        when st'_1' == ((simd_save_ns_state_spec_state_oracle st'_1));
        rely (
          (((((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)) /\
            ((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)))) /\
            ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)))) /\
            ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
            ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
        when ret_0 == ((rec_simd_type_spec' v_rec st'_1'));
        when st'_2 == ((simd_enable_spec_state_oracle st'_1'));
        rely (
          match (((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) =>
            ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (SLOT_REC_AUX0)) >=
                  (0)))) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (22)) <
                  (0)))))) /\
              (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
                (((16384 -
                  ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                  (0)))) \/
                (("slot_rec_aux0" = ("g_ns_simd"))))))
          | None =>
            ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (SLOT_REC_AUX0)) >=
                  (0)))) /\
                ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                  (22)) <
                  (0)))))) /\
              (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
                (((16384 -
                  ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                  (0)))) \/
                (("slot_rec_aux0" = ("g_ns_simd"))))))
          end);
        if (ret_0 =? (2))
        then (
          rely (
            match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
            | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
            end);
          when st'_3 == ((sve_config_vq_spec_state_oracle st'_2));
          rely (
            match (((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
            | (Some cid) => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
            end);
          when st'' == ((simd_restore_state_spec_state_oracle st'_3));
          rely (
            match (((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
            | (Some cid) => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
            | None => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
            end);
          when st''' == ((rec_simd_enable_restore_spec_state_oracle st''));
          (Some (false, st''')))
        else (
          rely (
            match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
            | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
            end);
          when st'_3 == ((simd_restore_state_spec_state_oracle st'_2));
          rely (
            match (((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
            | (Some cid) => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
            | None => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
            end);
          when st'_0' == ((rec_simd_enable_restore_spec_state_oracle st'_3));
          (Some (false, st'_0')))))
    else (
      when st' == ((realm_inject_undef_abort_spec_state_oracle st));
      (Some (false, st'))))
  else (
    if (((st.(share)).(gv_g_cpu_simd_type)) <>? (0))
    then (
      when st' == ((simd_enable_spec_state_oracle st));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      when st'_0 == ((sve_config_vq_spec_state_oracle st'));
      when st'' == ((simd_save_state_spec_state_oracle st'_0));
      when st'_1 == ((simd_disable_spec_state_oracle st''));
      when st'_1' == ((simd_save_ns_state_spec_state_oracle st'_1));
      rely (
        (((((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)) /\
          ((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)))) /\
          ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)))) /\
          ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
          ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
      when ret == ((rec_simd_type_spec' v_rec st'_1'));
      when st'_2 == ((simd_enable_spec_state_oracle st'_1'));
      rely (
        match (((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
        | (Some cid) =>
          ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
            ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (SLOT_REC_AUX0)) >=
                (0)))) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (22)) <
                (0)))))) /\
            (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
              (((16384 -
                ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                (0)))) \/
              (("slot_rec_aux0" = ("g_ns_simd"))))))
        | None =>
          ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
            ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (SLOT_REC_AUX0)) >=
                (0)))) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (22)) <
                (0)))))) /\
            (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
              (((16384 -
                ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                (0)))) \/
              (("slot_rec_aux0" = ("g_ns_simd"))))))
        end);
      if (ret =? (2))
      then (
        rely (
          match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        when st'_3 == ((sve_config_vq_spec_state_oracle st'_2));
        rely (
          match (((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        when st''_0 == ((simd_restore_state_spec_state_oracle st'_3));
        rely (
          match (((((st''_0.(share)).(granules)) @ (((st''_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) => ((((((st''_0.(share)).(granules)) @ (((st''_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
          | None => ((((((st''_0.(share)).(granules)) @ (((st''_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
          end);
        when st''' == ((rec_simd_enable_restore_spec_state_oracle st''_0));
        (Some (false, st''')))
      else (
        rely (
          match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        when st'_3 == ((simd_restore_state_spec_state_oracle st'_2));
        rely (
          match (((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
          end);
        when st'_0' == ((rec_simd_enable_restore_spec_state_oracle st'_3));
        (Some (false, st'_0'))))
    else (
      when st' == ((simd_enable_spec_state_oracle st));
      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
      when st'_0 == ((simd_save_state_spec_state_oracle st'));
      when st'_1 == ((simd_disable_spec_state_oracle st'_0));
      when st'_1' == ((simd_save_ns_state_spec_state_oracle st'_1));
      rely (
        (((((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) = (1)) /\
          ((((((st'_1'.(share)).(granules)) @ ((((st'_1'.(share)).(granule_data)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock)) = (None)))) /\
          ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)))) /\
          ((((((st'_1'.(share)).(granules)) @ (((st'_1'.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)))) /\
          ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
      when ret == ((rec_simd_type_spec' v_rec st'_1'));
      when st'_2 == ((simd_enable_spec_state_oracle st'_1'));
      rely (
        match (((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
        | (Some cid) =>
          ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
            ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (SLOT_REC_AUX0)) >=
                (0)))) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (22)) <
                (0)))))) /\
            (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
              (((16384 -
                ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                (0)))) \/
              (("slot_rec_aux0" = ("g_ns_simd"))))))
        | None =>
          ((((((((st'_2.(share)).(granules)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
            ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (GRANULES_BASE)) < (0)) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (SLOT_REC_AUX0)) >=
                (0)))) /\
              ((((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) / (GRANULE_SIZE)) -
                (22)) <
                (0)))))) /\
            (((("slot_rec_aux0" = ("slot_rec_aux0")) /\
              (((16384 -
                ((((((((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd)) - (SLOT_VIRT)) mod (65536)))) =
                (0)))) \/
              (("slot_rec_aux0" = ("g_ns_simd"))))))
        end);
      if (ret =? (2))
      then (
        rely (
          match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        when st'_3 == ((sve_config_vq_spec_state_oracle st'_2));
        rely (
          match (((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_3.(share)).(granules)) @ ((((st'_3.(share)).(granule_data)) @ (((st'_3.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        when st'' == ((simd_restore_state_spec_state_oracle st'_3));
        rely (
          match (((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
          | None => ((((((st''.(share)).(granules)) @ (((st''.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
          end);
        when st''' == ((rec_simd_enable_restore_spec_state_oracle st''));
        (Some (false, st''')))
      else (
        rely (
          match (((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_lock))) with
          | (Some cid) => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_2.(share)).(granules)) @ ((((st'_2.(share)).(granule_data)) @ (((st'_2.(share)).(slots)) @ SLOT_REC_AUX0)).(rec_gidx))).(e_refcount)) =? (1)) = (true))
          end);
        when st'_3 == ((simd_restore_state_spec_state_oracle st'_2));
        rely (
          match (((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
          | None => ((((((st'_3.(share)).(granules)) @ (((st'_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
          end);
        when st'_0' == ((rec_simd_enable_restore_spec_state_oracle st'_3));
        (Some (false, st'_0'))))).

Definition handle_instruction_abort_spec_mid (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  rely (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ ((((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")) /\ (((v_rec_exit.(poffset)) = (0)))))));
  if (fsc_is_external_abort_spec' (v_esr & (63)) st)
  then (
    if ((v_esr & (6144)) =? (4096))
    then (Some (false, st))
    else (
      when st' == ((inject_sync_idabort_spec_state_oracle st));
      (Some (false, (st'.[stack].[smc_rec_enter_stack] :< (((st'.(stack)).(smc_rec_enter_stack)) # 256 == (v_esr & (4227866175))))))))
  else (
    rely (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) =>
        ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
      | None =>
        ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
      end);
    if (
      ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
        ((((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)))) >?
        (0)))
    then (
      rely (
        ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\
          (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
            (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))))));
      rely (
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
          ((("granules" = ("granules")) /\
            ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | None =>
        if (
          (((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
            (6)) =?
            (0)))
        then (
          rely (
            match (
              ((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
            ) with
            | (Some cid) =>
              (((((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                (0)) =
                (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            | None =>
              ((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            end);
          when st_8 == (
              (rtt_walk_lock_unlock_spec
                (mkPtr "granules" ((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE))) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level)) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)) 
                (((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)) 
                3 
                (mkPtr "ipa_is_empty_stack" 0) 
                ((st.[log] :<
                  ((EVT
                    CPU_ID 
                    (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                    ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                  (sh.[granules] :<
                    ((sh.(granules)) #
                      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID)))))));
          rely (
            ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) > (0)) /\
              (((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >= (0)) /\ ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
              (((((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
                ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
          when ret == (
              (__tte_read_spec'
                (mkPtr "slot_rtt" (8 * ((((st_8.(stack)).(ipa_is_empty_stack)) @ 8)))) 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))));
          if (
            (s2tte_has_hipas_spec'
              ret 
              8 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))))
          then (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if ((v_esr & (60)) =? (4))
            then (
              (anno (((16 + (0)) = (16)));
              (anno (((0 + (16)) = (16)));
              (anno (((256 + (16)) = (272)));
              (anno (((0 + (272)) = (272)));
              (anno (((2048 * (0)) = (0)));
              (anno (((0 + (0)) = (0)));
              (anno (((256 + (0)) = (256)));
              (anno (((0 + (256)) = (256)));
              (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
              (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
              (Some (
                false  ,
                (((((st_8.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                    ((st_8.(log))))).[share].[granules] :<
                  (((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                  ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                  ((((st_8.(stack)).(smc_rec_enter_stack)) # 272 == (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) # 256 == (v_esr & (4227866175))))
              )))))))))))))
            else (
              (Some (
                false  ,
                ((((st_8.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                    ((st_8.(log))))).[share].[granules] :<
                  (((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                  ((st.(stack)).(ipa_is_empty_stack)))
              )))))
          else (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if (
              ((s2tte_get_ripas_spec'
                ret 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))) =?
                (0)))
            then (
              when st' == (
                  (inject_sync_idabort_spec_state_oracle
                    ((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack)))));
              (Some (true, st')))
            else (
              if ((v_esr & (60)) =? (4))
              then (
                (anno (((16 + (0)) = (16)));
                (anno (((0 + (16)) = (16)));
                (anno (((256 + (16)) = (272)));
                (anno (((0 + (272)) = (272)));
                (anno (((2048 * (0)) = (0)));
                (anno (((0 + (0)) = (0)));
                (anno (((256 + (0)) = (256)));
                (anno (((0 + (256)) = (256)));
                (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                (Some (
                  false  ,
                  (((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                    ((((st_8.(stack)).(smc_rec_enter_stack)) # 272 == (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) # 256 == (v_esr & (4227866175))))
                )))))))))))))
              else (
                (Some (
                  false  ,
                  ((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack)))
                )))))))
        else (
          rely (
            match (
              ((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
            ) with
            | (Some cid) =>
              (((((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                (0)) =
                (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            | None =>
              (((((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                (1)) =
                (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            end);
          when st_8 == (
              (rtt_walk_lock_unlock_spec
                (mkPtr "granules" ((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE))) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level)) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)) 
                (((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)) 
                3 
                (mkPtr "ipa_is_empty_stack" 0) 
                ((st.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID)))) ::
                    (((EVT
                      CPU_ID 
                      (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                      ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  (sh.[granules] :<
                    ((sh.(granules)) #
                      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        None))))));
          rely (
            ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) > (0)) /\
              (((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >= (0)) /\ ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
              (((((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
                ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
          when ret == (
              (__tte_read_spec'
                (mkPtr "slot_rtt" (8 * ((((st_8.(stack)).(ipa_is_empty_stack)) @ 8)))) 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))));
          if (
            (s2tte_has_hipas_spec'
              ret 
              8 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))))
          then (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if ((v_esr & (60)) =? (4))
            then (
              (anno (((16 + (0)) = (16)));
              (anno (((0 + (16)) = (16)));
              (anno (((256 + (16)) = (272)));
              (anno (((0 + (272)) = (272)));
              (anno (((2048 * (0)) = (0)));
              (anno (((0 + (0)) = (0)));
              (anno (((256 + (0)) = (256)));
              (anno (((0 + (256)) = (256)));
              (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
              (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
              (Some (
                false  ,
                (((((st_8.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                    ((st_8.(log))))).[share].[granules] :<
                  (((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                  ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                  ((((st_8.(stack)).(smc_rec_enter_stack)) # 272 == (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) # 256 == (v_esr & (4227866175))))
              )))))))))))))
            else (
              (Some (
                false  ,
                ((((st_8.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                    ((st_8.(log))))).[share].[granules] :<
                  (((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                  ((st.(stack)).(ipa_is_empty_stack)))
              )))))
          else (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if (
              ((s2tte_get_ripas_spec'
                ret 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))) =?
                (0)))
            then (
              when st' == (
                  (inject_sync_idabort_spec_state_oracle
                    ((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack)))));
              (Some (true, st')))
            else (
              if ((v_esr & (60)) =? (4))
              then (
                (anno (((16 + (0)) = (16)));
                (anno (((0 + (16)) = (16)));
                (anno (((256 + (16)) = (272)));
                (anno (((0 + (272)) = (272)));
                (anno (((2048 * (0)) = (0)));
                (anno (((0 + (0)) = (0)));
                (anno (((256 + (0)) = (256)));
                (anno (((0 + (256)) = (256)));
                (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                (Some (
                  false  ,
                  (((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                    ((((st_8.(stack)).(smc_rec_enter_stack)) # 272 == (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) # 256 == (v_esr & (4227866175))))
                )))))))))))))
              else (
                (Some (
                  false  ,
                  ((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack)))
                )))))))
      | (Some cid) => None
      end)
    else (
      when st' == ((inject_sync_idabort_spec_state_oracle st));
      (Some (true, st')))).

Definition handle_data_abort_spec_mid (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  rely (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ ((((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")) /\ (((v_rec_exit.(poffset)) = (0)))))));
  if (fsc_is_external_abort_spec' (v_esr & (63)) (st.[stack].[handle_data_abort_stack] :< (((st.(stack)).(handle_data_abort_stack)) # 0 == v_esr)))
  then (
    if ((v_esr & (6144)) =? (4096))
    then (Some (false, st))
    else (
      when st' == ((inject_sync_idabort_spec_state_oracle (st.[stack].[handle_data_abort_stack] :< (((st.(stack)).(handle_data_abort_stack)) # 0 == v_esr))));
      (Some (
        false  ,
        ((st'.[stack].[handle_data_abort_stack] :< ((st.(stack)).(handle_data_abort_stack))).[stack].[smc_rec_enter_stack] :<
          (((st'.(stack)).(smc_rec_enter_stack)) # 256 == (v_esr & (4227866175))))
      ))))
  else (
    rely (
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\
        (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))))));
    if (
      ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
        ((((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)))) >?
        (0)))
    then (
      rely (
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
          ((("granules" = ("granules")) /\
            ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | None =>
        if (
          (((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
            (6)) =?
            (0)))
        then (
          rely (
            match (
              ((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
            ) with
            | (Some cid) =>
              (((((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                (0)) =
                (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            | None =>
              ((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            end);
          when st_8 == (
              (rtt_walk_lock_unlock_spec
                (mkPtr "granules" ((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE))) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level)) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)) 
                (((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)) 
                3 
                (mkPtr "ipa_is_empty_stack" 0) 
                (((st.[log] :<
                  ((EVT
                    CPU_ID 
                    (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                    ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                  (sh.[granules] :<
                    ((sh.(granules)) #
                      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID))))).[stack].[handle_data_abort_stack] :<
                  (((st.(stack)).(handle_data_abort_stack)) # 0 == v_esr))));
          rely (
            ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) > (0)) /\
              (((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >= (0)) /\ ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
              (((((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
                ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
          when ret == (
              (__tte_read_spec'
                (mkPtr "slot_rtt" (8 * ((((st_8.(stack)).(ipa_is_empty_stack)) @ 8)))) 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))));
          if (
            (s2tte_has_hipas_spec'
              ret 
              8 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))))
          then (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if (((((st_8.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0))
            then (
              rely (
                match (
                  (((((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_lock))
                ) with
                | (Some cid_0) =>
                  ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                    ((((((((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                      (0)) =
                      (true))))
                | None =>
                  ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                    ((((((((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                      (1)) =
                      (true))))
                end);
              if (
                ((((1 << (((((((st_8.(share)).(granule_data)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
                  ((((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)))) >?
                  (0)))
              then (
                (anno (((256 + (0)) = (256)));
                (anno (((0 + (256)) = (256)));
                (anno (((8 + (0)) = (8)));
                (anno (((0 + (8)) = (8)));
                (anno (((256 + (8)) = (264)));
                (anno (((0 + (264)) = (264)));
                (anno (((16 + (0)) = (16)));
                (anno (((0 + (16)) = (16)));
                (anno (((256 + (16)) = (272)));
                (anno (((0 + (272)) = (272)));
                (anno (((2048 * (0)) = (0)));
                (anno (((8 * (0)) = (0)));
                (anno (((0 + (0)) = (0)));
                (anno (((512 + (0)) = (512)));
                (anno (((0 + (512)) = (512)));
                (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                (Some (
                  false  ,
                  ((((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                    ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                    ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4227866175))) # 264 == 0) #
                      272 ==
                      (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                      512 ==
                      0))
                ))))))))))))))))))))))
              else (
                if (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (64)) <>? (0))
                then (
                  when ret_0 == (
                      (get_dabt_write_value_spec'
                        v_rec 
                        (((st_8.(stack)).(handle_data_abort_stack)) @ 0) 
                        ((((st_8.[log] :<
                          ((EVT
                            CPU_ID 
                            (REL
                              (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                              (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                            ((st_8.(log))))).[share].[granules] :<
                          (((st_8.(share)).(granules)) #
                            (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                            ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                          (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                          ((st.(stack)).(ipa_is_empty_stack)))));
                  (anno (((256 + (0)) = (256)));
                  (anno (((0 + (256)) = (256)));
                  (anno (((8 + (0)) = (8)));
                  (anno (((0 + (8)) = (8)));
                  (anno (((256 + (8)) = (264)));
                  (anno (((0 + (264)) = (264)));
                  (anno (((16 + (0)) = (16)));
                  (anno (((0 + (16)) = (16)));
                  (anno (((256 + (16)) = (272)));
                  (anno (((0 + (272)) = (272)));
                  (anno (((2048 * (0)) = (0)));
                  (anno (((8 * (0)) = (0)));
                  (anno (((0 + (0)) = (0)));
                  (anno (((512 + (0)) = (512)));
                  (anno (((0 + (512)) = (512)));
                  (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                  (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                  (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                  (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                  (Some (
                    false  ,
                    ((((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                      ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                      ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                        264 ==
                        ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                        272 ==
                        (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                        512 ==
                        ret_0))
                  ))))))))))))))))))))))
                else (
                  (anno (((256 + (0)) = (256)));
                  (anno (((0 + (256)) = (256)));
                  (anno (((8 + (0)) = (8)));
                  (anno (((0 + (8)) = (8)));
                  (anno (((256 + (8)) = (264)));
                  (anno (((0 + (264)) = (264)));
                  (anno (((16 + (0)) = (16)));
                  (anno (((0 + (16)) = (16)));
                  (anno (((256 + (16)) = (272)));
                  (anno (((0 + (272)) = (272)));
                  (anno (((0 - (0)) = (0)));
                  (anno (((2048 * (0)) = (0)));
                  (anno (((8 * (0)) = (0)));
                  (anno (((0 + (0)) = (0)));
                  (anno (((512 + (0)) = (512)));
                  (anno (((0 + (512)) = (512)));
                  (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                  (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                  (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                  (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                  (Some (
                    false  ,
                    ((((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                      ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                      ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                        264 ==
                        ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                        272 ==
                        (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                        512 ==
                        0))
                  )))))))))))))))))))))))))
            else (
              (anno (((256 + (0)) = (256)));
              (anno (((0 + (256)) = (256)));
              (anno (((8 + (0)) = (8)));
              (anno (((0 + (8)) = (8)));
              (anno (((256 + (8)) = (264)));
              (anno (((0 + (264)) = (264)));
              (anno (((16 + (0)) = (16)));
              (anno (((0 + (16)) = (16)));
              (anno (((256 + (16)) = (272)));
              (anno (((0 + (272)) = (272)));
              (anno (((2048 * (0)) = (0)));
              (anno (((8 * (0)) = (0)));
              (anno (((0 + (0)) = (0)));
              (anno (((512 + (0)) = (512)));
              (anno (((0 + (512)) = (512)));
              (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
              (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
              (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
              (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
              (Some (
                false  ,
                ((((((st_8.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                    ((st_8.(log))))).[share].[granules] :<
                  (((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                  ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                  ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                  ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (18446744073692774399)) & (4227866175))) # 264 == 0) #
                    272 ==
                    (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                    512 ==
                    0))
              ))))))))))))))))))))))))
          else (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if (
              ((s2tte_get_ripas_spec'
                ret 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))) =?
                (0)))
            then (
              when st' == (
                  (inject_sync_idabort_spec_state_oracle
                    ((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack)))));
              (Some (true, (st'.[stack].[handle_data_abort_stack] :< ((st.(stack)).(handle_data_abort_stack))))))
            else (
              if (((((st_8.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0))
              then (
                rely (
                  match (
                    (((((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_lock))
                  ) with
                  | (Some cid_0) =>
                    ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                      ((((((((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                        (0)) =
                        (true))))
                  | None =>
                    ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                      ((((((((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                        (1)) =
                        (true))))
                  end);
                if (
                  ((((1 << (((((((st_8.(share)).(granule_data)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
                    ((((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)))) >?
                    (0)))
                then (
                  (anno (((256 + (0)) = (256)));
                  (anno (((0 + (256)) = (256)));
                  (anno (((8 + (0)) = (8)));
                  (anno (((0 + (8)) = (8)));
                  (anno (((256 + (8)) = (264)));
                  (anno (((0 + (264)) = (264)));
                  (anno (((16 + (0)) = (16)));
                  (anno (((0 + (16)) = (16)));
                  (anno (((256 + (16)) = (272)));
                  (anno (((0 + (272)) = (272)));
                  (anno (((2048 * (0)) = (0)));
                  (anno (((8 * (0)) = (0)));
                  (anno (((0 + (0)) = (0)));
                  (anno (((512 + (0)) = (512)));
                  (anno (((0 + (512)) = (512)));
                  (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                  (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                  (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                  (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                  (Some (
                    false  ,
                    ((((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                      ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                      ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4227866175))) # 264 == 0) #
                        272 ==
                        (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                        512 ==
                        0))
                  ))))))))))))))))))))))
                else (
                  if (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (64)) <>? (0))
                  then (
                    when ret_0 == (
                        (get_dabt_write_value_spec'
                          v_rec 
                          (((st_8.(stack)).(handle_data_abort_stack)) @ 0) 
                          ((((st_8.[log] :<
                            ((EVT
                              CPU_ID 
                              (REL
                                (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                                (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                              ((st_8.(log))))).[share].[granules] :<
                            (((st_8.(share)).(granules)) #
                              (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                              ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                            (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                            ((st.(stack)).(ipa_is_empty_stack)))));
                    (anno (((256 + (0)) = (256)));
                    (anno (((0 + (256)) = (256)));
                    (anno (((8 + (0)) = (8)));
                    (anno (((0 + (8)) = (8)));
                    (anno (((256 + (8)) = (264)));
                    (anno (((0 + (264)) = (264)));
                    (anno (((16 + (0)) = (16)));
                    (anno (((0 + (16)) = (16)));
                    (anno (((256 + (16)) = (272)));
                    (anno (((0 + (272)) = (272)));
                    (anno (((2048 * (0)) = (0)));
                    (anno (((8 * (0)) = (0)));
                    (anno (((0 + (0)) = (0)));
                    (anno (((512 + (0)) = (512)));
                    (anno (((0 + (512)) = (512)));
                    (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                    (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                    (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                    (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                    (Some (
                      false  ,
                      ((((((st_8.[log] :<
                        ((EVT
                          CPU_ID 
                          (REL
                            (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                            (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                          ((st_8.(log))))).[share].[granules] :<
                        (((st_8.(share)).(granules)) #
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                          ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                        (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                        ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                        ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                        ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                          264 ==
                          ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                          272 ==
                          (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                          512 ==
                          ret_0))
                    ))))))))))))))))))))))
                  else (
                    (anno (((256 + (0)) = (256)));
                    (anno (((0 + (256)) = (256)));
                    (anno (((8 + (0)) = (8)));
                    (anno (((0 + (8)) = (8)));
                    (anno (((256 + (8)) = (264)));
                    (anno (((0 + (264)) = (264)));
                    (anno (((16 + (0)) = (16)));
                    (anno (((0 + (16)) = (16)));
                    (anno (((256 + (16)) = (272)));
                    (anno (((0 + (272)) = (272)));
                    (anno (((0 - (0)) = (0)));
                    (anno (((2048 * (0)) = (0)));
                    (anno (((8 * (0)) = (0)));
                    (anno (((0 + (0)) = (0)));
                    (anno (((512 + (0)) = (512)));
                    (anno (((0 + (512)) = (512)));
                    (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                    (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                    (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                    (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                    (Some (
                      false  ,
                      ((((((st_8.[log] :<
                        ((EVT
                          CPU_ID 
                          (REL
                            (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                            (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                          ((st_8.(log))))).[share].[granules] :<
                        (((st_8.(share)).(granules)) #
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                          ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                        (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                        ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                        ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                        ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                          264 ==
                          ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                          272 ==
                          (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                          512 ==
                          0))
                    )))))))))))))))))))))))))
              else (
                (anno (((256 + (0)) = (256)));
                (anno (((0 + (256)) = (256)));
                (anno (((8 + (0)) = (8)));
                (anno (((0 + (8)) = (8)));
                (anno (((256 + (8)) = (264)));
                (anno (((0 + (264)) = (264)));
                (anno (((16 + (0)) = (16)));
                (anno (((0 + (16)) = (16)));
                (anno (((256 + (16)) = (272)));
                (anno (((0 + (272)) = (272)));
                (anno (((2048 * (0)) = (0)));
                (anno (((8 * (0)) = (0)));
                (anno (((0 + (0)) = (0)));
                (anno (((512 + (0)) = (512)));
                (anno (((0 + (512)) = (512)));
                (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                (Some (
                  false  ,
                  ((((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                    ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                    ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (18446744073692774399)) & (4227866175))) # 264 == 0) #
                      272 ==
                      (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                      512 ==
                      0))
                ))))))))))))))))))))))))))
        else (
          rely (
            match (
              ((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
            ) with
            | (Some cid) =>
              (((((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                (0)) =
                (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            | None =>
              (((((((sh.(granules)) #
                ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                  None)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                (1)) =
                (true)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
                  (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                    ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
            end);
          when st_8 == (
              (rtt_walk_lock_unlock_spec
                (mkPtr "granules" ((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE))) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level)) 
                (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)) 
                (((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)) 
                3 
                (mkPtr "ipa_is_empty_stack" 0) 
                (((st.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID)))) ::
                    (((EVT
                      CPU_ID 
                      (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                      ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                  (sh.[granules] :<
                    ((sh.(granules)) #
                      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        None)))).[stack].[handle_data_abort_stack] :<
                  (((st.(stack)).(handle_data_abort_stack)) # 0 == v_esr))));
          rely (
            ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) > (0)) /\
              (((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >= (0)) /\ ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
              (((((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
                ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
          when ret == (
              (__tte_read_spec'
                (mkPtr "slot_rtt" (8 * ((((st_8.(stack)).(ipa_is_empty_stack)) @ 8)))) 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))));
          if (
            (s2tte_has_hipas_spec'
              ret 
              8 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))))
          then (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if (((((st_8.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0))
            then (
              rely (
                match (
                  (((((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_lock))
                ) with
                | (Some cid_0) =>
                  ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                    ((((((((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                      (0)) =
                      (true))))
                | None =>
                  ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                    ((((((((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                      (1)) =
                      (true))))
                end);
              if (
                ((((1 << (((((((st_8.(share)).(granule_data)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
                  ((((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)))) >?
                  (0)))
              then (
                (anno (((256 + (0)) = (256)));
                (anno (((0 + (256)) = (256)));
                (anno (((8 + (0)) = (8)));
                (anno (((0 + (8)) = (8)));
                (anno (((256 + (8)) = (264)));
                (anno (((0 + (264)) = (264)));
                (anno (((16 + (0)) = (16)));
                (anno (((0 + (16)) = (16)));
                (anno (((256 + (16)) = (272)));
                (anno (((0 + (272)) = (272)));
                (anno (((2048 * (0)) = (0)));
                (anno (((8 * (0)) = (0)));
                (anno (((0 + (0)) = (0)));
                (anno (((512 + (0)) = (512)));
                (anno (((0 + (512)) = (512)));
                (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                (Some (
                  false  ,
                  ((((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                    ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                    ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4227866175))) # 264 == 0) #
                      272 ==
                      (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                      512 ==
                      0))
                ))))))))))))))))))))))
              else (
                if (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (64)) <>? (0))
                then (
                  when ret_0 == (
                      (get_dabt_write_value_spec'
                        v_rec 
                        (((st_8.(stack)).(handle_data_abort_stack)) @ 0) 
                        ((((st_8.[log] :<
                          ((EVT
                            CPU_ID 
                            (REL
                              (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                              (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                            ((st_8.(log))))).[share].[granules] :<
                          (((st_8.(share)).(granules)) #
                            (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                            ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                          (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                          ((st.(stack)).(ipa_is_empty_stack)))));
                  (anno (((256 + (0)) = (256)));
                  (anno (((0 + (256)) = (256)));
                  (anno (((8 + (0)) = (8)));
                  (anno (((0 + (8)) = (8)));
                  (anno (((256 + (8)) = (264)));
                  (anno (((0 + (264)) = (264)));
                  (anno (((16 + (0)) = (16)));
                  (anno (((0 + (16)) = (16)));
                  (anno (((256 + (16)) = (272)));
                  (anno (((0 + (272)) = (272)));
                  (anno (((2048 * (0)) = (0)));
                  (anno (((8 * (0)) = (0)));
                  (anno (((0 + (0)) = (0)));
                  (anno (((512 + (0)) = (512)));
                  (anno (((0 + (512)) = (512)));
                  (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                  (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                  (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                  (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                  (Some (
                    false  ,
                    ((((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                      ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                      ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                        264 ==
                        ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                        272 ==
                        (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                        512 ==
                        ret_0))
                  ))))))))))))))))))))))
                else (
                  (anno (((256 + (0)) = (256)));
                  (anno (((0 + (256)) = (256)));
                  (anno (((8 + (0)) = (8)));
                  (anno (((0 + (8)) = (8)));
                  (anno (((256 + (8)) = (264)));
                  (anno (((0 + (264)) = (264)));
                  (anno (((16 + (0)) = (16)));
                  (anno (((0 + (16)) = (16)));
                  (anno (((256 + (16)) = (272)));
                  (anno (((0 + (272)) = (272)));
                  (anno (((0 - (0)) = (0)));
                  (anno (((2048 * (0)) = (0)));
                  (anno (((8 * (0)) = (0)));
                  (anno (((0 + (0)) = (0)));
                  (anno (((512 + (0)) = (512)));
                  (anno (((0 + (512)) = (512)));
                  (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                  (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                  (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                  (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                  (Some (
                    false  ,
                    ((((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                      ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                      ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                        264 ==
                        ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                        272 ==
                        (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                        512 ==
                        0))
                  )))))))))))))))))))))))))
            else (
              (anno (((256 + (0)) = (256)));
              (anno (((0 + (256)) = (256)));
              (anno (((8 + (0)) = (8)));
              (anno (((0 + (8)) = (8)));
              (anno (((256 + (8)) = (264)));
              (anno (((0 + (264)) = (264)));
              (anno (((16 + (0)) = (16)));
              (anno (((0 + (16)) = (16)));
              (anno (((256 + (16)) = (272)));
              (anno (((0 + (272)) = (272)));
              (anno (((2048 * (0)) = (0)));
              (anno (((8 * (0)) = (0)));
              (anno (((0 + (0)) = (0)));
              (anno (((512 + (0)) = (512)));
              (anno (((0 + (512)) = (512)));
              (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
              (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
              (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
              (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
              (Some (
                false  ,
                ((((((st_8.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                    ((st_8.(log))))).[share].[granules] :<
                  (((st_8.(share)).(granules)) #
                    (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                  (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                  ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                  ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                  ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (18446744073692774399)) & (4227866175))) # 264 == 0) #
                    272 ==
                    (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                    512 ==
                    0))
              ))))))))))))))))))))))))
          else (
            when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (anno (((- 1) = ((- 1))));
            if (
              ((s2tte_get_ripas_spec'
                ret 
                (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))) =?
                (0)))
            then (
              when st' == (
                  (inject_sync_idabort_spec_state_oracle
                    ((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack)))));
              (Some (true, (st'.[stack].[handle_data_abort_stack] :< ((st.(stack)).(handle_data_abort_stack))))))
            else (
              if (((((st_8.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0))
              then (
                rely (
                  match (
                    (((((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_lock))
                  ) with
                  | (Some cid_0) =>
                    ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                      ((((((((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                        (0)) =
                        (true))))
                  | None =>
                    ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                      ((((((((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(e_refcount)) =?
                        (1)) =
                        (true))))
                  end);
                if (
                  ((((1 << (((((((st_8.(share)).(granule_data)) @ ((((st_8.(share)).(slots)) # SLOT_RTT == (- 1)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
                    ((((((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2)) << (8)) & (4503599627366400)))) >?
                    (0)))
                then (
                  (anno (((256 + (0)) = (256)));
                  (anno (((0 + (256)) = (256)));
                  (anno (((8 + (0)) = (8)));
                  (anno (((0 + (8)) = (8)));
                  (anno (((256 + (8)) = (264)));
                  (anno (((0 + (264)) = (264)));
                  (anno (((16 + (0)) = (16)));
                  (anno (((0 + (16)) = (16)));
                  (anno (((256 + (16)) = (272)));
                  (anno (((0 + (272)) = (272)));
                  (anno (((2048 * (0)) = (0)));
                  (anno (((8 * (0)) = (0)));
                  (anno (((0 + (0)) = (0)));
                  (anno (((512 + (0)) = (512)));
                  (anno (((0 + (512)) = (512)));
                  (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                  (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                  (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                  (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                  (Some (
                    false  ,
                    ((((((st_8.[log] :<
                      ((EVT
                        CPU_ID 
                        (REL
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                          (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                        ((st_8.(log))))).[share].[granules] :<
                      (((st_8.(share)).(granules)) #
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                      (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                      ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                      ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                      ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4227866175))) # 264 == 0) #
                        272 ==
                        (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                        512 ==
                        0))
                  ))))))))))))))))))))))
                else (
                  if (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (64)) <>? (0))
                  then (
                    when ret_0 == (
                        (get_dabt_write_value_spec'
                          v_rec 
                          (((st_8.(stack)).(handle_data_abort_stack)) @ 0) 
                          ((((st_8.[log] :<
                            ((EVT
                              CPU_ID 
                              (REL
                                (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                                (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                              ((st_8.(log))))).[share].[granules] :<
                            (((st_8.(share)).(granules)) #
                              (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                              ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                            (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
                            ((st.(stack)).(ipa_is_empty_stack)))));
                    (anno (((256 + (0)) = (256)));
                    (anno (((0 + (256)) = (256)));
                    (anno (((8 + (0)) = (8)));
                    (anno (((0 + (8)) = (8)));
                    (anno (((256 + (8)) = (264)));
                    (anno (((0 + (264)) = (264)));
                    (anno (((16 + (0)) = (16)));
                    (anno (((0 + (16)) = (16)));
                    (anno (((256 + (16)) = (272)));
                    (anno (((0 + (272)) = (272)));
                    (anno (((2048 * (0)) = (0)));
                    (anno (((8 * (0)) = (0)));
                    (anno (((0 + (0)) = (0)));
                    (anno (((512 + (0)) = (512)));
                    (anno (((0 + (512)) = (512)));
                    (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                    (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                    (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                    (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                    (Some (
                      false  ,
                      ((((((st_8.[log] :<
                        ((EVT
                          CPU_ID 
                          (REL
                            (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                            (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                          ((st_8.(log))))).[share].[granules] :<
                        (((st_8.(share)).(granules)) #
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                          ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                        (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                        ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                        ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                        ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                          264 ==
                          ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                          272 ==
                          (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                          512 ==
                          ret_0))
                    ))))))))))))))))))))))
                  else (
                    (anno (((256 + (0)) = (256)));
                    (anno (((0 + (256)) = (256)));
                    (anno (((8 + (0)) = (8)));
                    (anno (((0 + (8)) = (8)));
                    (anno (((256 + (8)) = (264)));
                    (anno (((0 + (264)) = (264)));
                    (anno (((16 + (0)) = (16)));
                    (anno (((0 + (16)) = (16)));
                    (anno (((256 + (16)) = (272)));
                    (anno (((0 + (272)) = (272)));
                    (anno (((0 - (0)) = (0)));
                    (anno (((2048 * (0)) = (0)));
                    (anno (((8 * (0)) = (0)));
                    (anno (((0 + (0)) = (0)));
                    (anno (((512 + (0)) = (512)));
                    (anno (((0 + (512)) = (512)));
                    (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                    (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                    (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                    (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                    (Some (
                      false  ,
                      ((((((st_8.[log] :<
                        ((EVT
                          CPU_ID 
                          (REL
                            (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                            (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                          ((st_8.(log))))).[share].[granules] :<
                        (((st_8.(share)).(granules)) #
                          (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                          ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                        (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                        ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                        ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                        ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == ((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (4257259135))) #
                          264 ==
                          ((((st_8.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                          272 ==
                          (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                          512 ==
                          0))
                    )))))))))))))))))))))))))
              else (
                (anno (((256 + (0)) = (256)));
                (anno (((0 + (256)) = (256)));
                (anno (((8 + (0)) = (8)));
                (anno (((0 + (8)) = (8)));
                (anno (((256 + (8)) = (264)));
                (anno (((0 + (264)) = (264)));
                (anno (((16 + (0)) = (16)));
                (anno (((0 + (16)) = (16)));
                (anno (((256 + (16)) = (272)));
                (anno (((0 + (272)) = (272)));
                (anno (((2048 * (0)) = (0)));
                (anno (((8 * (0)) = (0)));
                (anno (((0 + (0)) = (0)));
                (anno (((512 + (0)) = (512)));
                (anno (((0 + (512)) = (512)));
                (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
                (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
                (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
                (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
                (Some (
                  false  ,
                  ((((((st_8.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                      ((st_8.(log))))).[share].[granules] :<
                    (((st_8.(share)).(granules)) #
                      (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
                    (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[handle_data_abort_stack] :<
                    ((st.(stack)).(handle_data_abort_stack))).[stack].[ipa_is_empty_stack] :<
                    ((st.(stack)).(ipa_is_empty_stack))).[stack].[smc_rec_enter_stack] :<
                    ((((((st_8.(stack)).(smc_rec_enter_stack)) # 256 == (((((st_8.(stack)).(handle_data_abort_stack)) @ 0) & (18446744073692774399)) & (4227866175))) # 264 == 0) #
                      272 ==
                      (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                      512 ==
                      0))
                ))))))))))))))))))))))))))
      | (Some cid) => None
      end)
    else (
      if (((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0))
      then (
        if ((v_esr & (64)) <>? (0))
        then (
          when ret == ((get_dabt_write_value_spec' v_rec v_esr (st.[stack].[handle_data_abort_stack] :< (((st.(stack)).(handle_data_abort_stack)) # 0 == v_esr))));
          (anno (((256 + (0)) = (256)));
          (anno (((0 + (256)) = (256)));
          (anno (((8 + (0)) = (8)));
          (anno (((0 + (8)) = (8)));
          (anno (((256 + (8)) = (264)));
          (anno (((0 + (264)) = (264)));
          (anno (((16 + (0)) = (16)));
          (anno (((0 + (16)) = (16)));
          (anno (((256 + (16)) = (272)));
          (anno (((0 + (272)) = (272)));
          (anno (((2048 * (0)) = (0)));
          (anno (((8 * (0)) = (0)));
          (anno (((0 + (0)) = (0)));
          (anno (((512 + (0)) = (512)));
          (anno (((0 + (512)) = (512)));
          (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
          (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
          (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
          (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
          (Some (
            false  ,
            (st.[stack].[smc_rec_enter_stack] :<
              ((((((st.(stack)).(smc_rec_enter_stack)) # 256 == (v_esr & (4257259135))) # 264 == ((((st.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                272 ==
                (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                512 ==
                ret))
          ))))))))))))))))))))))
        else (
          (anno (((256 + (0)) = (256)));
          (anno (((0 + (256)) = (256)));
          (anno (((8 + (0)) = (8)));
          (anno (((0 + (8)) = (8)));
          (anno (((256 + (8)) = (264)));
          (anno (((0 + (264)) = (264)));
          (anno (((16 + (0)) = (16)));
          (anno (((0 + (16)) = (16)));
          (anno (((256 + (16)) = (272)));
          (anno (((0 + (272)) = (272)));
          (anno (((0 - (0)) = (0)));
          (anno (((2048 * (0)) = (0)));
          (anno (((8 * (0)) = (0)));
          (anno (((0 + (0)) = (0)));
          (anno (((512 + (0)) = (512)));
          (anno (((0 + (512)) = (512)));
          (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
          (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
          (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
          (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
          (Some (
            false  ,
            (st.[stack].[smc_rec_enter_stack] :<
              ((((((st.(stack)).(smc_rec_enter_stack)) # 256 == (v_esr & (4257259135))) # 264 == ((((st.(priv)).(pcpu_regs)).(pcpu_far_el2)) & (4095))) #
                272 ==
                (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
                512 ==
                0))
          ))))))))))))))))))))))))
      else (
        (anno (((256 + (0)) = (256)));
        (anno (((0 + (256)) = (256)));
        (anno (((8 + (0)) = (8)));
        (anno (((0 + (8)) = (8)));
        (anno (((256 + (8)) = (264)));
        (anno (((0 + (264)) = (264)));
        (anno (((16 + (0)) = (16)));
        (anno (((0 + (16)) = (16)));
        (anno (((256 + (16)) = (272)));
        (anno (((0 + (272)) = (272)));
        (anno (((2048 * (0)) = (0)));
        (anno (((8 * (0)) = (0)));
        (anno (((0 + (0)) = (0)));
        (anno (((512 + (0)) = (512)));
        (anno (((0 + (512)) = (512)));
        (anno ((((v_rec_exit.(poffset)) + (256)) = (256)));
        (anno ((((v_rec_exit.(poffset)) + (264)) = (264)));
        (anno ((((v_rec_exit.(poffset)) + (272)) = (272)));
        (anno ((((v_rec_exit.(poffset)) + (512)) = (512)));
        (Some (
          false  ,
          (st.[stack].[smc_rec_enter_stack] :<
            ((((((st.(stack)).(smc_rec_enter_stack)) # 256 == ((v_esr & (18446744073692774399)) & (4227866175))) # 264 == 0) #
              272 ==
              (((st.(priv)).(pcpu_regs)).(pcpu_hpfar_el2))) #
              512 ==
              0))
        )))))))))))))))))))))))).

Definition handle_sysreg_access_trap_spec_mid (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  let v_0 := v_esr in
  let v_1 := (v_0 >> (5)) in
  let v_conv := (v_1 & (31)) in
  let v_and3 := (3275776 & (v_esr)) in
  let v_cmp4 := (v_and3 =? (3145728)) in
  match (
    let v_i_0_lcssa := 0 in
    let __retval__ := false in
    let __return__ := false in
    if v_cmp4
    then (
      let v_i_0_lcssa := 0 in
      (Some (__return__, __retval__, v_i_0_lcssa, st)))
    else (
      let v_and3_1 := (3210256 & (v_esr)) in
      let v_cmp4_1 := (v_and3_1 =? (3158032)) in
      match (
        let v_i_0_lcssa := 0 in
        let __retval__ := false in
        let __return__ := false in
        if v_cmp4_1
        then (
          let v_i_0_lcssa := 1 in
          (Some (__return__, __retval__, v_i_0_lcssa, st)))
        else (
          let v_and3_2 := (4193310 & (v_esr)) in
          let v_cmp4_2 := (v_and3_2 =? (3149836)) in
          match (
            let v_i_0_lcssa := 0 in
            let __retval__ := false in
            let __return__ := false in
            if v_cmp4_2
            then (
              let v_i_0_lcssa := 2 in
              (Some (__return__, __retval__, v_i_0_lcssa, st)))
            else (
              let v_and9 := (v_esr & (1)) in
              let v_tobool10 := (v_and9 <>? (0)) in
              let v_cmp11 := (v_conv <>? (31)) in
              let v_or_cond := (v_tobool10 && (v_cmp11)) in
              when st == (
                  if v_or_cond
                  then (
                    let v_idxprom14 := v_conv in
                    rely (((0 <= (v_idxprom14)) /\ ((v_idxprom14 < (31)))));
                    let v_arrayidx15 := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (v_idxprom14)) + (0))))))) in
                    when st == ((store_RData 8 v_arrayidx15 0 st));
                    (Some st))
                  else (Some st));
              let v_retval_0 := true in
              let __return__ := true in
              let __retval__ := v_retval_0 in
              (Some (__return__, __retval__, v_i_0_lcssa, st)))
          ) with
          | (Some (__return__, __retval__, v_i_0_lcssa, st)) =>
            if __return__
            then (Some (__return__, __retval__, v_i_0_lcssa, st))
            else (Some (__return__, __retval__, v_i_0_lcssa, st))
          | None => None
          end)
      ) with
      | (Some (__return__, __retval__, v_i_0_lcssa, st)) =>
        if __return__
        then (Some (__return__, __retval__, v_i_0_lcssa, st))
        else (Some (__return__, __retval__, v_i_0_lcssa, st))
      | None => None
      end)
  ) with
  | (Some (__return__, __retval__, v_i_0_lcssa, st)) =>
    if __return__
    then (Some (__retval__, st))
    else (
      let v_conv1_le := v_i_0_lcssa in
      rely (((0 <= (v_conv1_le)) /\ ((v_conv1_le < (3)))));
      let v_fn := (ptr_offset (mkPtr "sysreg_handlers" 0) (((24 * (3)) * (0)) + (((24 * (v_conv1_le)) + ((16 + (0))))))) in
      when v_2_tmp, st == ((load_RData 8 v_fn st));
      let v_2 := (int_to_ptr v_2_tmp) in
      when v_call, st == ((handle_sysreg_access_trap_funptr_wrap301 v_2 v_rec v_rec_exit v_esr st));
      when st == (
          if v_call
          then (Some st)
          else (
            when st == ((emulate_sysreg_access_ns_spec v_rec v_rec_exit v_esr st));
            (Some st)));
      let v_retval_0 := v_call in
      let __return__ := true in
      let __retval__ := v_retval_0 in
      (Some (__retval__, st)))
  | None => None
  end.

Definition handle_rsi_realm_config_spec_mid (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  when st == ((new_frame "handle_rsi_realm_config" st));
  let init_st := st in
  when v_walk_res, st == ((alloc_stack "handle_rsi_realm_config" 32 8 st));
  let v_0 := (ptr_offset v_agg_result ((56 * (0)) + ((0 + ((0 + (0))))))) in
  when st == ((llvm_memset_p0i8_i64_spec v_0 0 56 false st));
  rely (((0 <= (1)) /\ ((1 < (31)))));
  let v_arrayidx := (ptr_offset v_rec ((3272 * (0)) + ((24 + (((8 * (1)) + (0))))))) in
  when v_1, st == ((load_RData 8 v_arrayidx st));
  let v_rem := (v_1 & (4095)) in
  let v_cmp := (v_rem =? (0)) in
  when __return__, st == (
      let __return__ := false in
      if v_cmp
      then (
        when v_call, st == ((addr_in_rec_par_spec v_rec v_1 st));
        when __return__, st == (
            let __return__ := false in
            if v_call
            then (
              let v_g_rd := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((24 + (0))))))) in
              when v_2_tmp, st == ((load_RData 8 v_g_rd st));
              let v_2 := (int_to_ptr v_2_tmp) in
              when v_call2, st == ((granule_map_spec v_2 2 st));
              let v_3 := v_call2 in
              when v_call3, st == ((realm_ipa_to_pa_spec v_3 v_1 v_walk_res st));
              let v_cmp4 := (v_call3 =? (2)) in
              when st == (
                  if v_cmp4
                  then (
                    when v_call6, st == ((s2_walk_result_match_ripas_spec v_walk_res 0 st));
                    when st == (
                        if v_call6
                        then (
                          rely (((0 <= (0)) /\ ((0 < (5)))));
                          let v_arrayidx10 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (0)) + (0))))))))) in
                          when st == ((store_RData 8 v_arrayidx10 1 st));
                          (Some st))
                        else (
                          let v_abort := (ptr_offset v_agg_result ((56 * (0)) + ((0 + ((0 + (0))))))) in
                          when st == ((store_RData 1 v_abort 1 st));
                          let v_rtt_level := (ptr_offset v_walk_res ((32 * (0)) + ((8 + (0))))) in
                          when v_4, st == ((load_RData 8 v_rtt_level st));
                          let v_rtt_level12 := (ptr_offset v_agg_result ((56 * (0)) + ((0 + ((8 + (0))))))) in
                          when st == ((store_RData 8 v_rtt_level12 v_4 st));
                          (Some st)));
                    (Some st))
                  else (
                    let v_cmp15 := (v_call3 =? (1)) in
                    when st == (
                        if v_cmp15
                        then (
                          rely (((0 <= (0)) /\ ((0 < (5)))));
                          let v_arrayidx19 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (0)) + (0))))))))) in
                          when st == ((store_RData 8 v_arrayidx19 1 st));
                          (Some st))
                        else (
                          let v_pa := (ptr_offset v_walk_res ((32 * (0)) + ((0 + (0))))) in
                          when v_5, st == ((load_RData 8 v_pa st));
                          when v_call21, st == ((find_granule_spec v_5 st));
                          when v_call22, st == ((granule_map_spec v_call21 24 st));
                          let v_ipa_bits := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((0 + (0))))))) in
                          when v_6, st == ((load_RData 8 v_ipa_bits st));
                          let v_ipa_width := v_call22 in
                          when st == ((store_RData 8 v_ipa_width v_6 st));
                          when st == ((buffer_unmap_spec v_call22 st));
                          let v_llt := (ptr_offset v_walk_res ((32 * (0)) + ((24 + (0))))) in
                          when v_7_tmp, st == ((load_RData 8 v_llt st));
                          let v_7 := (int_to_ptr v_7_tmp) in
                          when st == ((granule_unlock_spec v_7 st));
                          rely (((0 <= (0)) /\ ((0 < (5)))));
                          let v_arrayidx26 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (0)) + (0))))))))) in
                          when st == ((store_RData 8 v_arrayidx26 0 st));
                          (Some st)));
                    (Some st)));
              when st == ((buffer_unmap_spec v_call2 st));
              let __return__ := true in
              (Some (__return__, st)))
            else (Some (__return__, st)));
        if __return__
        then (Some (__return__, st))
        else (Some (__return__, st)))
      else (Some (__return__, st)));
  if __return__
  then (
    when st == ((free_stack "handle_rsi_realm_config" init_st st));
    (Some st))
  else (
    rely (((0 <= (0)) /\ ((0 < (5)))));
    let v_arrayidx1 := (ptr_offset v_agg_result ((56 * (0)) + ((16 + ((0 + (((8 * (0)) + (0))))))))) in
    when st == ((store_RData 8 v_arrayidx1 1 st));
    let __return__ := true in
    when st == ((free_stack "handle_rsi_realm_config" init_st st));
    (Some st)).

