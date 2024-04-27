Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MemRW_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_buffer_write_spec (v_slot: Z) (v_ns_gr: Ptr) (v_offset: Z) (v_size: Z) (v_src: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((v_offset = (0)));
    rely ((((v_ns_gr.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_ns_gr.(pbase)) = ("granules")));
    rely ((v_slot = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    if ((18446744073709420544 + ((v_offset & (4095)))) >? (0))
    then (
      if (((18446744073709420544 + ((v_offset & (4095)))) - (MAX_ERR)) >=? (0))
      then (
        when v_call5, st_1 == (
            (memcpy_ns_write_spec_state_oracle
              (mkPtr "status" ((18446744073709420544 + ((v_offset & (4095)))) - (MAX_ERR)))
              v_src
              v_size
              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
      else (
        if ((v_offset & (4095)) >=? (0))
        then (
          if (((v_offset & (4095)) / (GRANULE_SIZE)) =? (0))
          then (
            when v_call5, st_1 == (
                (memcpy_ns_write_spec_state_oracle
                  (mkPtr "slot_ns" (v_offset & (4095)))
                  v_src
                  v_size
                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
          else (
            if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_DELEGATED)) =? (0))
            then (
              when v_call5, st_1 == (
                  (memcpy_ns_write_spec_state_oracle
                    (mkPtr "slot_delegated" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                    v_src
                    v_size
                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
              rely (("slot_ns" = ("slot_ns")));
              rely ((0 = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
            else (
              if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_RD)) =? (0))
              then (
                when v_call5, st_1 == (
                    (memcpy_ns_write_spec_state_oracle
                      (mkPtr "slot_rd" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                      v_src
                      v_size
                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                rely (("slot_ns" = ("slot_ns")));
                rely ((0 = (0)));
                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
              else (
                if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
                then (
                  when v_call5, st_1 == (
                      (memcpy_ns_write_spec_state_oracle
                        (mkPtr "slot_rec" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                        v_src
                        v_size
                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                  rely (("slot_ns" = ("slot_ns")));
                  rely ((0 = (0)));
                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                else (
                  if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
                  then (
                    when v_call5, st_1 == (
                        (memcpy_ns_write_spec_state_oracle
                          (mkPtr "slot_rec2" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                          v_src
                          v_size
                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                    rely (("slot_ns" = ("slot_ns")));
                    rely ((0 = (0)));
                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                  else (
                    if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
                    then (
                      when v_call5, st_1 == (
                          (memcpy_ns_write_spec_state_oracle
                            (mkPtr "slot_rec_target" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                            v_src
                            v_size
                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                      rely (("slot_ns" = ("slot_ns")));
                      rely ((0 = (0)));
                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                    else (
                      if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (22)) <? (0))
                      then (
                        when v_call5, st_1 == (
                            (memcpy_ns_write_spec_state_oracle
                              (mkPtr "slot_rec_aux0" ((v_offset & (4095)) mod (65536)))
                              v_src
                              v_size
                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                        rely (("slot_ns" = ("slot_ns")));
                        rely ((0 = (0)));
                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                      else (
                        if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                        then (
                          when v_call5, st_1 == (
                              (memcpy_ns_write_spec_state_oracle
                                (mkPtr "slot_rtt" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                                v_src
                                v_size
                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                          rely (("slot_ns" = ("slot_ns")));
                          rely ((0 = (0)));
                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                        else (
                          if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                          then (
                            when v_call5, st_1 == (
                                (memcpy_ns_write_spec_state_oracle
                                  (mkPtr "slot_rtt2" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                                  v_src
                                  v_size
                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                            rely (("slot_ns" = ("slot_ns")));
                            rely ((0 = (0)));
                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                          else (
                            if ((((v_offset & (4095)) / (GRANULE_SIZE)) - (SLOT_RSI_CALL)) =? (0))
                            then (
                              when v_call5, st_1 == (
                                  (memcpy_ns_write_spec_state_oracle
                                    (mkPtr "slot_rsi_call" ((v_offset & (4095)) mod (GRANULE_SIZE)))
                                    v_src
                                    v_size
                                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                              rely (("slot_ns" = ("slot_ns")));
                              rely ((0 = (0)));
                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                            else (
                              when v_call5, st_1 == ((memcpy_ns_write_spec_state_oracle (mkPtr "null" 0) v_src v_size (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                              rely (("slot_ns" = ("slot_ns")));
                              rely ((0 = (0)));
                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))))))))))))
        else (
          if (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) >=? (0))
          then (
            if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_setup_platform_token)) =? (0))
            then (
              when v_call5, st_1 == (
                  (memcpy_ns_write_spec_state_oracle
                    (mkPtr "attest_setup_platform_token_stack" ((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)))
                    v_src
                    v_size
                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
              rely (("slot_ns" = ("slot_ns")));
              rely ((0 = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
            else (
              if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_psci_complete)) =? (0))
              then (
                when v_call5, st_1 == (
                    (memcpy_ns_write_spec_state_oracle
                      (mkPtr "smc_psci_complete_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                      v_src
                      v_size
                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                rely (("slot_ns" = ("slot_ns")));
                rely ((0 = (0)));
                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
              else (
                if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_find_lock_two_granules)) =? (0))
                then (
                  when v_call5, st_1 == (
                      (memcpy_ns_write_spec_state_oracle
                        (mkPtr "find_lock_two_granules_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                        v_src
                        v_size
                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                  rely (("slot_ns" = ("slot_ns")));
                  rely ((0 = (0)));
                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                else (
                  if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_token_continue_write_state)) =? (0))
                  then (
                    when v_call5, st_1 == (
                        (memcpy_ns_write_spec_state_oracle
                          (mkPtr "attest_token_continue_write_state_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                          v_src
                          v_size
                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                    rely (("slot_ns" = ("slot_ns")));
                    rely ((0 = (0)));
                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                  else (
                    if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_rmm_log)) =? (0))
                    then (
                      when v_call5, st_1 == (
                          (memcpy_ns_write_spec_state_oracle
                            (mkPtr "rmm_log_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                            v_src
                            v_size
                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                      rely (("slot_ns" = ("slot_ns")));
                      rely ((0 = (0)));
                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                    else (
                      if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_realm_token_create)) =? (0))
                      then (
                        when v_call5, st_1 == (
                            (memcpy_ns_write_spec_state_oracle
                              (mkPtr "attest_realm_token_create_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                              v_src
                              v_size
                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                        rely (("slot_ns" = ("slot_ns")));
                        rely ((0 = (0)));
                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                      else (
                        if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rec_enter)) =? (0))
                        then (
                          when v_call5, st_1 == (
                              (memcpy_ns_write_spec_state_oracle
                                (mkPtr "smc_rec_enter_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                v_src
                                v_size
                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                          rely (("slot_ns" = ("slot_ns")));
                          rely ((0 = (0)));
                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                        else (
                          if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_do_host_call)) =? (0))
                          then (
                            when v_call5, st_1 == (
                                (memcpy_ns_write_spec_state_oracle
                                  (mkPtr "do_host_call_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                  v_src
                                  v_size
                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                            rely (("slot_ns" = ("slot_ns")));
                            rely ((0 = (0)));
                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                          else (
                            if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_rnd_prng_init)) =? (0))
                            then (
                              when v_call5, st_1 == (
                                  (memcpy_ns_write_spec_state_oracle
                                    (mkPtr "attest_rnd_prng_init_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                    v_src
                                    v_size
                                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                              rely (("slot_ns" = ("slot_ns")));
                              rely ((0 = (0)));
                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                            else (
                              if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_plat_setup)) =? (0))
                              then (
                                when v_call5, st_1 == (
                                    (memcpy_ns_write_spec_state_oracle
                                      (mkPtr "plat_setup_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                      v_src
                                      v_size
                                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                rely (("slot_ns" = ("slot_ns")));
                                rely ((0 = (0)));
                                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                              else (
                                if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_token_encode_start)) =? (0))
                                then (
                                  when v_call5, st_1 == (
                                      (memcpy_ns_write_spec_state_oracle
                                        (mkPtr "attest_token_encode_start_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                        v_src
                                        v_size
                                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                  rely (("slot_ns" = ("slot_ns")));
                                  rely ((0 = (0)));
                                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                else (
                                  if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_data_destroy)) =? (0))
                                  then (
                                    when v_call5, st_1 == (
                                        (memcpy_ns_write_spec_state_oracle
                                          (mkPtr "smc_data_destroy_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                          v_src
                                          v_size
                                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                    rely (("slot_ns" = ("slot_ns")));
                                    rely ((0 = (0)));
                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                  else (
                                    if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_xlat_get_llt_from_va)) =? (0))
                                    then (
                                      when v_call5, st_1 == (
                                          (memcpy_ns_write_spec_state_oracle
                                            (mkPtr "xlat_get_llt_from_va_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                            v_src
                                            v_size
                                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                      rely (("slot_ns" = ("slot_ns")));
                                      rely ((0 = (0)));
                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                    else (
                                      if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rec_create)) =? (0))
                                      then (
                                        when v_call5, st_1 == (
                                            (memcpy_ns_write_spec_state_oracle
                                              (mkPtr "smc_rec_create_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                              v_src
                                              v_size
                                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                        rely (("slot_ns" = ("slot_ns")));
                                        rely ((0 = (0)));
                                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                      else (
                                        if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_measurement_extend_sha512)) =? (0))
                                        then (
                                          when v_call5, st_1 == (
                                              (memcpy_ns_write_spec_state_oracle
                                                (mkPtr "measurement_extend_sha512_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                v_src
                                                v_size
                                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                          rely (("slot_ns" = ("slot_ns")));
                                          rely ((0 = (0)));
                                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                        else (
                                          if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_data_granule_measure)) =? (0))
                                          then (
                                            when v_call5, st_1 == (
                                                (memcpy_ns_write_spec_state_oracle
                                                  (mkPtr "data_granule_measure_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                  v_src
                                                  v_size
                                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                            rely (("slot_ns" = ("slot_ns")));
                                            rely ((0 = (0)));
                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                          else (
                                            if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_sort_granules)) =? (0))
                                            then (
                                              when v_call5, st_1 == (
                                                  (memcpy_ns_write_spec_state_oracle
                                                    (mkPtr "sort_granules_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                    v_src
                                                    v_size
                                                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                              rely (("slot_ns" = ("slot_ns")));
                                              rely ((0 = (0)));
                                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                            else (
                                              if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_measurement_extend_sha256)) =? (0))
                                              then (
                                                when v_call5, st_1 == (
                                                    (memcpy_ns_write_spec_state_oracle
                                                      (mkPtr "measurement_extend_sha256_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                      v_src
                                                      v_size
                                                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                rely (("slot_ns" = ("slot_ns")));
                                                rely ((0 = (0)));
                                                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                              else (
                                                if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_realm_ipa_to_pa)) =? (0))
                                                then (
                                                  when v_call5, st_1 == (
                                                      (memcpy_ns_write_spec_state_oracle
                                                        (mkPtr "realm_ipa_to_pa_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                        v_src
                                                        v_size
                                                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                  rely (("slot_ns" = ("slot_ns")));
                                                  rely ((0 = (0)));
                                                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                else (
                                                  if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_realm_token_sign)) =? (0))
                                                  then (
                                                    when v_call5, st_1 == (
                                                        (memcpy_ns_write_spec_state_oracle
                                                          (mkPtr "attest_realm_token_sign_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                          v_src
                                                          v_size
                                                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                    rely (("slot_ns" = ("slot_ns")));
                                                    rely ((0 = (0)));
                                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                  else (
                                                    if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_rmm_el3_ifc_get_platform_token)) =? (0))
                                                    then (
                                                      when v_call5, st_1 == (
                                                          (memcpy_ns_write_spec_state_oracle
                                                            (mkPtr "rmm_el3_ifc_get_platform_token_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                            v_src
                                                            v_size
                                                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                      rely (("slot_ns" = ("slot_ns")));
                                                      rely ((0 = (0)));
                                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                    else (
                                                      if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_init_realm_attestation_key)) =? (0))
                                                      then (
                                                        when v_call5, st_1 == (
                                                            (memcpy_ns_write_spec_state_oracle
                                                              (mkPtr "attest_init_realm_attestation_key_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                              v_src
                                                              v_size
                                                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                        rely (("slot_ns" = ("slot_ns")));
                                                        rely ((0 = (0)));
                                                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                      else (
                                                        if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_plat_cmn_setup)) =? (0))
                                                        then (
                                                          when v_call5, st_1 == (
                                                              (memcpy_ns_write_spec_state_oracle
                                                                (mkPtr "plat_cmn_setup_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                v_src
                                                                v_size
                                                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                          rely (("slot_ns" = ("slot_ns")));
                                                          rely ((0 = (0)));
                                                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                        else (
                                                          if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_complete_rsi_host_call)) =? (0))
                                                          then (
                                                            when v_call5, st_1 == (
                                                                (memcpy_ns_write_spec_state_oracle
                                                                  (mkPtr "complete_rsi_host_call_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                  v_src
                                                                  v_size
                                                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                            rely (("slot_ns" = ("slot_ns")));
                                                            rely ((0 = (0)));
                                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                          else (
                                                            if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_handle_realm_rsi)) =? (0))
                                                            then (
                                                              when v_call5, st_1 == (
                                                                  (memcpy_ns_write_spec_state_oracle
                                                                    (mkPtr "handle_realm_rsi_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                    v_src
                                                                    v_size
                                                                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                              rely (("slot_ns" = ("slot_ns")));
                                                              rely ((0 = (0)));
                                                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                            else (
                                                              if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rtt_set_ripas)) =? (0))
                                                              then (
                                                                when v_call5, st_1 == (
                                                                    (memcpy_ns_write_spec_state_oracle
                                                                      (mkPtr "smc_rtt_set_ripas_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                      v_src
                                                                      v_size
                                                                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                rely (("slot_ns" = ("slot_ns")));
                                                                rely ((0 = (0)));
                                                                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                              else (
                                                                if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_rtt_walk_lock_unlock)) =? (0))
                                                                then (
                                                                  when v_call5, st_1 == (
                                                                      (memcpy_ns_write_spec_state_oracle
                                                                        (mkPtr "rtt_walk_lock_unlock_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                        v_src
                                                                        v_size
                                                                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                  rely (("slot_ns" = ("slot_ns")));
                                                                  rely ((0 = (0)));
                                                                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                else (
                                                                  if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rtt_destroy)) =? (0))
                                                                  then (
                                                                    when v_call5, st_1 == (
                                                                        (memcpy_ns_write_spec_state_oracle
                                                                          (mkPtr "smc_rtt_destroy_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                          v_src
                                                                          v_size
                                                                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                    rely (("slot_ns" = ("slot_ns")));
                                                                    rely ((0 = (0)));
                                                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                  else (
                                                                    if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_map_unmap_ns)) =? (0))
                                                                    then (
                                                                      when v_call5, st_1 == (
                                                                          (memcpy_ns_write_spec_state_oracle
                                                                            (mkPtr "map_unmap_ns_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                            v_src
                                                                            v_size
                                                                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                      rely (("slot_ns" = ("slot_ns")));
                                                                      rely ((0 = (0)));
                                                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                    else (
                                                                      if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_handle_rsi_attest_token_init)) =? (0))
                                                                      then (
                                                                        when v_call5, st_1 == (
                                                                            (memcpy_ns_write_spec_state_oracle
                                                                              (mkPtr "handle_rsi_attest_token_init_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                              v_src
                                                                              v_size
                                                                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                        rely (("slot_ns" = ("slot_ns")));
                                                                        rely ((0 = (0)));
                                                                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                      else (
                                                                        if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_realm_params_measure)) =? (0))
                                                                        then (
                                                                          when v_call5, st_1 == (
                                                                              (memcpy_ns_write_spec_state_oracle
                                                                                (mkPtr "realm_params_measure_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                v_src
                                                                                v_size
                                                                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                          rely (("slot_ns" = ("slot_ns")));
                                                                          rely ((0 = (0)));
                                                                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                        else (
                                                                          if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_handle_rsi_ipa_state_get)) =? (0))
                                                                          then (
                                                                            when v_call5, st_1 == (
                                                                                (memcpy_ns_write_spec_state_oracle
                                                                                  (mkPtr "handle_rsi_ipa_state_get_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                  v_src
                                                                                  v_size
                                                                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                            rely (("slot_ns" = ("slot_ns")));
                                                                            rely ((0 = (0)));
                                                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                          else (
                                                                            if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_realm_ipa_get_ripas)) =? (0))
                                                                            then (
                                                                              when v_call5, st_1 == (
                                                                                  (memcpy_ns_write_spec_state_oracle
                                                                                    (mkPtr "realm_ipa_get_ripas_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                    v_src
                                                                                    v_size
                                                                                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                              rely (("slot_ns" = ("slot_ns")));
                                                                              rely ((0 = (0)));
                                                                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                            else (
                                                                              if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rtt_fold)) =? (0))
                                                                              then (
                                                                                when v_call5, st_1 == (
                                                                                    (memcpy_ns_write_spec_state_oracle
                                                                                      (mkPtr "smc_rtt_fold_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                      v_src
                                                                                      v_size
                                                                                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                rely (("slot_ns" = ("slot_ns")));
                                                                                rely ((0 = (0)));
                                                                                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                              else (
                                                                                if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rtt_create)) =? (0))
                                                                                then (
                                                                                  when v_call5, st_1 == (
                                                                                      (memcpy_ns_write_spec_state_oracle
                                                                                        (mkPtr "smc_rtt_create_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                        v_src
                                                                                        v_size
                                                                                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                  rely (("slot_ns" = ("slot_ns")));
                                                                                  rely ((0 = (0)));
                                                                                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                else (
                                                                                  if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_rsi_log_on_exit)) =? (0))
                                                                                  then (
                                                                                    when v_call5, st_1 == (
                                                                                        (memcpy_ns_write_spec_state_oracle
                                                                                          (mkPtr "rsi_log_on_exit_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                          v_src
                                                                                          v_size
                                                                                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                    rely (("slot_ns" = ("slot_ns")));
                                                                                    rely ((0 = (0)));
                                                                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                  else (
                                                                                    if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_attest_cca_token_create)) =? (0))
                                                                                    then (
                                                                                      when v_call5, st_1 == (
                                                                                          (memcpy_ns_write_spec_state_oracle
                                                                                            (mkPtr "attest_cca_token_create_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                            v_src
                                                                                            v_size
                                                                                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                      rely (("slot_ns" = ("slot_ns")));
                                                                                      rely ((0 = (0)));
                                                                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                    else (
                                                                                      if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_rec_params_measure)) =? (0))
                                                                                      then (
                                                                                        when v_call5, st_1 == (
                                                                                            (memcpy_ns_write_spec_state_oracle
                                                                                              (mkPtr "rec_params_measure_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                              v_src
                                                                                              v_size
                                                                                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                        rely (("slot_ns" = ("slot_ns")));
                                                                                        rely ((0 = (0)));
                                                                                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                      else (
                                                                                        if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_handle_ns_smc)) =? (0))
                                                                                        then (
                                                                                          when v_call5, st_1 == (
                                                                                              (memcpy_ns_write_spec_state_oracle
                                                                                                (mkPtr "handle_ns_smc_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                v_src
                                                                                                v_size
                                                                                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                          rely (("slot_ns" = ("slot_ns")));
                                                                                          rely ((0 = (0)));
                                                                                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                        else (
                                                                                          if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_rmm_el3_ifc_get_realm_attest_key)) =? (0))
                                                                                          then (
                                                                                            when v_call5, st_1 == (
                                                                                                (memcpy_ns_write_spec_state_oracle
                                                                                                  (mkPtr "rmm_el3_ifc_get_realm_attest_key_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                  v_src
                                                                                                  v_size
                                                                                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                            rely (("slot_ns" = ("slot_ns")));
                                                                                            rely ((0 = (0)));
                                                                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                          else (
                                                                                            if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_handle_rsi_realm_config)) =? (0))
                                                                                            then (
                                                                                              when v_call5, st_1 == (
                                                                                                  (memcpy_ns_write_spec_state_oracle
                                                                                                    (mkPtr "handle_rsi_realm_config_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                    v_src
                                                                                                    v_size
                                                                                                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                              rely (("slot_ns" = ("slot_ns")));
                                                                                              rely ((0 = (0)));
                                                                                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                            else (
                                                                                              if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rtt_init_ripas)) =? (0))
                                                                                              then (
                                                                                                when v_call5, st_1 == (
                                                                                                    (memcpy_ns_write_spec_state_oracle
                                                                                                      (mkPtr "smc_rtt_init_ripas_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                      v_src
                                                                                                      v_size
                                                                                                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                rely (("slot_ns" = ("slot_ns")));
                                                                                                rely ((0 = (0)));
                                                                                                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                              else (
                                                                                                if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_rtt_read_entry)) =? (0))
                                                                                                then (
                                                                                                  when v_call5, st_1 == (
                                                                                                      (memcpy_ns_write_spec_state_oracle
                                                                                                        (mkPtr "smc_rtt_read_entry_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                        v_src
                                                                                                        v_size
                                                                                                        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                  rely (("slot_ns" = ("slot_ns")));
                                                                                                  rely ((0 = (0)));
                                                                                                  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                  (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                                else (
                                                                                                  if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_handle_data_abort)) =? (0))
                                                                                                  then (
                                                                                                    when v_call5, st_1 == (
                                                                                                        (memcpy_ns_write_spec_state_oracle
                                                                                                          (mkPtr "handle_data_abort_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                          v_src
                                                                                                          v_size
                                                                                                          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                    rely (("slot_ns" = ("slot_ns")));
                                                                                                    rely ((0 = (0)));
                                                                                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                                  else (
                                                                                                    if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_data_create)) =? (0))
                                                                                                    then (
                                                                                                      when v_call5, st_1 == (
                                                                                                          (memcpy_ns_write_spec_state_oracle
                                                                                                            (mkPtr "data_create_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                            v_src
                                                                                                            v_size
                                                                                                            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                      rely (("slot_ns" = ("slot_ns")));
                                                                                                      rely ((0 = (0)));
                                                                                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                      (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                                    else (
                                                                                                      if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_smc_realm_create)) =? (0))
                                                                                                      then (
                                                                                                        when v_call5, st_1 == (
                                                                                                            (memcpy_ns_write_spec_state_oracle
                                                                                                              (mkPtr "smc_realm_create_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                              v_src
                                                                                                              v_size
                                                                                                              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                        rely (("slot_ns" = ("slot_ns")));
                                                                                                        rely ((0 = (0)));
                                                                                                        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                                      else (
                                                                                                        if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_ripas_granule_measure)) =? (0))
                                                                                                        then (
                                                                                                          when v_call5, st_1 == (
                                                                                                              (memcpy_ns_write_spec_state_oracle
                                                                                                                (mkPtr "ripas_granule_measure_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                                v_src
                                                                                                                v_size
                                                                                                                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                          rely (("slot_ns" = ("slot_ns")));
                                                                                                          rely ((0 = (0)));
                                                                                                          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                          (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                                        else (
                                                                                                          if ((((((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) / (GRANULE_SIZE)) + (STACK_slot_ofs)) - (STACK_ipa_is_empty)) =? (0))
                                                                                                          then (
                                                                                                            when v_call5, st_1 == (
                                                                                                                (memcpy_ns_write_spec_state_oracle
                                                                                                                  (mkPtr "ipa_is_empty_stack" (((18446744073709420544 + ((v_offset & (4095)))) - (STACK_VIRT)) mod (GRANULE_SIZE)))
                                                                                                                  v_src
                                                                                                                  v_size
                                                                                                                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                            rely (("slot_ns" = ("slot_ns")));
                                                                                                            rely ((0 = (0)));
                                                                                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
                                                                                                          else (
                                                                                                            when v_call5, st_1 == ((memcpy_ns_write_spec_state_oracle (mkPtr "null" 0) v_src v_size (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
                                                                                                            rely (("slot_ns" = ("slot_ns")));
                                                                                                            rely ((0 = (0)));
                                                                                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                                                                            (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))))))))))))))))))))))))))))))))))))))))))))))))))
          else (
            if (((18446744073709420544 + ((v_offset & (4095)))) - (GRANULES_BASE)) >=? (0))
            then (
              when v_call5, st_1 == (
                  (memcpy_ns_write_spec_state_oracle
                    (mkPtr "granules" ((18446744073709420544 + ((v_offset & (4095)))) - (GRANULES_BASE)))
                    v_src
                    v_size
                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
              rely (("slot_ns" = ("slot_ns")));
              rely ((0 = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
            else (
              when v_call5, st_1 == ((memcpy_ns_write_spec_state_oracle (mkPtr "null" 0) v_src v_size (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
              rely (("slot_ns" = ("slot_ns")));
              rely ((0 = (0)));
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))))))
    else (
      if ((18446744073709420544 + ((v_offset & (4095)))) <? (0))
      then (
        when v_call5, st_1 == (
            (memcpy_ns_write_spec_state_oracle
              (mkPtr "status" (- (18446744073709420544 + ((v_offset & (4095))))))
              v_src
              v_size
              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
        rely (("slot_ns" = ("slot_ns")));
        rely ((0 = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))
      else (
        when v_call5, st_1 == ((memcpy_ns_write_spec_state_oracle (mkPtr "null" 0) v_src v_size (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
        rely (("slot_ns" = ("slot_ns")));
        rely ((0 = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))))).

  Definition ns_buffer_read_spec (v_slot: Z) (v_ns_gr: Ptr) (v_offset: Z) (v_size: Z) (v_dest: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((v_offset = (0)));
    rely ((((v_ns_gr.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_ns_gr.(pbase)) = ("granules")));
    rely ((v_slot = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely ((((18446744073709420544 + ((v_offset & (4095)))) >? (0)) = (true)));
    rely (((((18446744073709420544 + ((v_offset & (4095)))) - (MAX_ERR)) >=? (0)) = (false)));
    rely ((((v_offset & (4095)) >=? (0)) = (true)));
    rely (((((v_offset & (4095)) / (GRANULE_SIZE)) =? (0)) = (true)));
    when v_call5, st_1 == (
        (memcpy_ns_read_spec_state_oracle
          v_dest
          (mkPtr "slot_ns" (v_offset & (4095)))
          v_size
          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_ns_gr.(poffset)) >> (4))))));
    (Some (v_call5, (st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_NS == (- 1))))).

  Definition granule_memzero_mapped_spec (v_buf: Ptr) (st: RData) : (option RData) :=
    rely (((v_buf.(pbase)) = ("slot_rtt2")));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_RTT2) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< zero_granule_data_normal)))).

  Definition granule_memzero_spec (v_g: Ptr) (v_slot: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g.(pbase)) = ("granules")));
    rely ((v_slot <= (24)));
    rely ((v_slot >= (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    if (v_slot =? (0))
    then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_NS == ((v_g.(poffset)) >> (4))) # SLOT_NS == (- 1))))
    else (
      if (
        if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_DELEGATED)) =? (0))
        then true
        else false)
      then (
        when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) >> (4))).(e_lock)));
        (Some ((st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) # ((v_g.(poffset)) >> (4)) == ((((st.(share)).(granule_data)) @ ((v_g.(poffset)) >> (4))).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
          ((((st.(share)).(slots)) # SLOT_DELEGATED == ((v_g.(poffset)) >> (4))) # SLOT_DELEGATED == (- 1)))))
      else (
        if (
          if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RD)) =? (0))
          then true
          else false)
        then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == ((v_g.(poffset)) >> (4))) # SLOT_RD == (- 1))))
        else (
          if (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
            then true
            else false)
          then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC == ((v_g.(poffset)) >> (4))) # SLOT_REC == (- 1))))
          else (
            if (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
              then true
              else false)
            then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC2 == ((v_g.(poffset)) >> (4))) # SLOT_REC2 == (- 1))))
            else (
              if (
                if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
                then true
                else false)
              then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC_TARGET == ((v_g.(poffset)) >> (4))) # SLOT_REC_TARGET == (- 1))))
              else (
                if (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (22)) <? (0))
                  then true
                  else false)
                then (
                  rely ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (65536)) = (0)));
                  (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC_AUX0 == ((v_g.(poffset)) >> (4))) # SLOT_REC_AUX0 == (- 1)))))
                else (
                  if (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                    then true
                    else false)
                  then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g.(poffset)) >> (4))) # SLOT_RTT == (- 1))))
                  else (
                    if (
                      if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                      then true
                      else false)
                    then (
                      when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) >> (4))).(e_lock)));
                      (Some ((st.[share].[granule_data] :<
                        (((st.(share)).(granule_data)) # ((v_g.(poffset)) >> (4)) == ((((st.(share)).(granule_data)) @ ((v_g.(poffset)) >> (4))).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
                        ((((st.(share)).(slots)) # SLOT_RTT2 == ((v_g.(poffset)) >> (4))) # SLOT_RTT2 == (- 1)))))
                    else (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RSI_CALL == ((v_g.(poffset)) >> (4))) # SLOT_RSI_CALL == (- 1)))))))))))).

End MemRW_Spec.

#[global] Hint Unfold ns_buffer_write_spec: spec.
#[global] Hint Unfold ns_buffer_read_spec: spec.
#[global] Hint Unfold granule_memzero_mapped_spec: spec.
#[global] Hint Unfold granule_memzero_spec: spec.
