## Build

(This script runs on m400, use cross-compile if not).

See `veriframe/preprocessing/readme.md` for more details.

(1) Build all passes, Spoq and IR2Json in the veriframe submodule.

(2) Run ``preprocessing/get-ir.sh`` to get llvm IR and its json version from source codes. 
```
// make sure the working directory is rcsm-rmm/verification
veriframe/preprocessing/get-ir.sh ..
```
You will get three files: `rmm.linked.ll`(the original IR), `rmm-opt.linked.ll`(the processed IR that we will later work on), and `rmm-opt.linked.ir2json.json`(the Json version of processed IR).

(3) Run ``preprocessing/extract-info.sh`` to extract generated datatypes, stack variables, and global variables definitions.
```
// make sure the working directory is rcsm-rmm/verification
veriframe/preprocessing/extract-info.sh rmm-opt.linked.ll
```
You will get two files: `rmm-opt.linked.ll.datatype.v`(datatype definitions that are ready for use), `/rmm-opt.linked.ll.machine.v`(abstract machine model that requires further modifications).

(4) Modify `/rmm-opt.linked.ll.machine.v` to make it work.

(5) Suppose now we have a good datatype definition (`coq/datatype.pure.v`) and a good machine model (`machine.pure.v`). Note that these two files might not be up-to-date and have bugs. Check `working.v` for the using datatypes and machine model.

(6) To get the layer config, run
```
// make sure the working directory is rcsm-rmm/verification
python3 veriframe/preprocessing/gen-layer.py rmm-opt.linked.ir2json.json top-bottom.json coq/datatype.pure.v coq/machine.pure.v
```
The top-bottom.json is a simple json in the form of :
```
{
  "top": ["func1", "func2"],
  "bottom": ["func3"]
}
```
that pre-define the top layer and the bottom layer.
You will get two file: the layer config file in Json(rmm-opt.linked.ir2json.gen.default-config.json) which only contains the function name and its corresponding layer, and the Spoq config file(rmm-opt.linked.ir2json.gen.default-config.v). 

(7) Suppose we want to run spoq with `working.v`, we just run

```
// make sure the working directory is rcsm-rmm/verification
veriframe/build/spoq working.v

```
You will get a proof directory under the `coq` directory that contains the proofs. Put `LayerSem` in the `coq` directory, then you can `make` the proof direcotry and get the result.

```
// make sure you have set up LayerSem and Coq path
// make sure the working directory is rcsm-rmm/verification/coq/working
coq_makefile -f _CoqProject -o Makefile
make
```

LLVM-14 is required.

## Hack
The function `assert` in `/users/rongyi/rcsm-rmm/include/assert.h` has been temporally masked to remove reasoning for `printf`-class. 


## Progress

`working.v` is the one that we are working on.

Run `veriframe/build/spoq working.v` under `rcsm-rmm/verification`. 

`cd coq`.

Put `LayerSem` under this coq directory and compile it.

Run `make` under the `coq/working` directory.


### Layer 1
- [x]    "__sca_read64": (* moved to Bottom for now *)
- [x]    "buffer_map" 
- [x]    "granule_addr"

### Layer 2
- [x]    "__tte_read" 
- [x]    "granule_map" : in its high spec, when calling `buffer_map_spec'`, the first argument will be mistakenly rewritten as `false`, resulting in a type mismatch bug.
- [x]    "granule_from_idx"
- [x]    "addr_to_idx"
- [x]    "addr_level_mask" (* may require further manual spec *)
- [x]    "granule_get_state"
- [ ]    "spinlock_acquire"
- [ ]    "spinlock_release"

### Layer 3
- [x]    "entry_is_table"
- [x]    "__table_get_entry"
- [x]    "addr_to_granule" Subtraction is converted to adding 2's complement in the code. This may cause low-level proof trouble in the future. 
- [x]    "table_entry_to_phys"
- [x]    "granule_try_lock"

### Layer 4
- [x]    "__find_next_level_idx"
- [x]    "s2_addr_to_idx"
- [x]    "__sca_write64_release": (* Give explicit spec *)
- [x]    "__sca_read64_acquire": (* Give explicit spec *)
- [x]    "atomic_add_64": (* Give explicit spec *)
- [x]    "cpuid"
- [x]    "find_granule" with manual spec 
- [x]    "granule_lock"
- [ ]    "llvm.memcpy.p0i8.p0i8.i64": (* Give explicit tmp spec *)
- [x]    "s2tte_create_ripas"

### Layer 5
- [x]    "s2tte_is_table"
- [x]    "granule_unlock"
- [x]    "s2_sl_addr_to_idx"
- [x]    "llvm.memset.p0i8.i64"
- [x]    "__find_lock_next_level"
- [x]    "addr_is_contained"
- [x]    "set_rd_state"
- [x]    "get_rd_rec_count_unlocked"
- [ ]    "monitor_call": (* Give explicit tmp spec *)
- [x]    "pack_struct_return_code"
- [x]    "make_return_code"
- [x]    "atomic_granule_get"
- [x]    "atomic_granule_put"
- [x]    "__sca_write64": (* Give explicit spec *)
- [x]    "slot_to_va"
- [x]    "memcpy_ns_read"
- [x]    "granule_pa_to_va"
- [x]    "find_lock_granule"
- [x]    "sort_granules"
- [x]    "s2tte_create_unassigned"

### Layer 6
- [x]    "esr_sysreg_rt"
- [x]    "esr_sas"
- [x]    "get_realm_identity"
- [x]    "s2tte_map_size"
- [x]    "s2tte_pa"
- [x]    "s2tte_is_valid"
- [x]    "rtt_walk_lock_unlock"
- [x]    "realm_ipa_bits"
- [x]    "realm_rtt_starting_level"
- [x]    "is_addr_in_par"
- [ ]    "system_off_reboot"
- [x]    "rd_map_read_rec_count"
- [x]    "vmpidr_to_rec_idx"
- [x]    "g_mapped_addr_set"
- [x]    "granule_set_state"
- [x]    "set_pas_ns_to_any"
- [x]    "pack_return_code"
- [x]    "__granule_get"
- [x]    "g_refcount"
- [x]    "__granule_put"
- [x]    "set_pas_any_to_ns"
- [x]    "s2tte_create_assigned"
- [x]    "__tte_write": (* Give explicit spec *)
- [x]    "stage1_tlbi_all"
- [x]    "s1tte_pa"
- [x]    "s2tte_is_unassigned"
- [x]    "s1tte_create_valid"
- [x]    "s2tte_get_ripas"
- [ ]    "memset": (* Give explicit tmp spec *)
- [x]    "ns_buffer_unmap"
- [x]    "ns_buffer_read"
- [x]    "find_lock_granules": (* Give explicit spec *)
- [x]    "s2tte_create_table"
- [x]    "s2tt_init_unassigned"

### Layer 7
- [x]    "s1addr_level_mask"
- [x]    "ranges_intersect"
- [x]    "get_sysreg_write_value"
- [x]    "esr_srt"
- [x]    "access_mask"
- [ ]    "create_realm_token" (* TODO: add ExtractValue instr *)
- [x]    "memcpy" (* move to Bottom *)
- [x]    "realm_ipa_to_pa"
- [x]    "psci_cpu_off"
- [x]    "psci_system_reset"
- [x]    "psci_system_off"
- [x]    "psci_affinity_info"
- [x]    "psci_features"
- [x]    "psci_cpu_suspend"
- [x]    "psci_cpu_on"
- [x]    "psci_version"
- [x]    "region_is_contained"
- [x]    "get_tte" (* TODO: move to bottom *)
- [ ]    "memcpy_ns_read_byte" (* TODO: move to bottom *)
- [x]    "s1tte_is_valid"
- [x]    "smc_granule_ns_to_any"
- [x]    "smc_granule_any_to_ns"
- [ ]    "memcpy_ns_write_byte" (* TODO: move to bottom *)
- [x]    "granule_unlock_transition"
- [x]    "data_create_internal"
- [x]    "find_lock_two_granules"
- [x]    "rtt_create_internal" (* 40 mins, give cached spec *)
- [x]    "s2tte_is_assigned"

### Layer 8
- [x]    "max_pa_size"
- [x]    "addr_is_level_aligned"
- [x]    "s1addr_is_level_aligned"
- [x]    "realm_ipa_size"
- [x]    "range_intersects_par"
- [x]    "emulate_sysreg_access_ns"
- [x]    "esr_is_write"
- [x]    "access_len"
- [x]    "fixup_aarch32_data_abort"
- [x]    "get_dabt_write_value"
- [ ]    "handle_rsi_realm_get_attest_token"
- [x]    "emulate_stage2_data_abort"
- [x]    "psci_rsi" (* Give generated spec, cost 15 min *)
- [x]    "handle_rsi_realm_extend_measurement"
- [x]    "rsi_memory_dispose"
- [x]    "write_lr"
- [x]    "write_ap1r"
- [x]    "write_ap0r"
- [x]    "masked_assign"
- [x]    "set_tte_ns"
- [x]    "set_pas_ns"
- [x]    "granule_memzero"
- [x]    "clear_tte_ns"
- [x]    "set_pas_realm"
- [x]    "ns_buffer_read_byte" (* move to bottom *)
- [x]    "min"
- [x]    "next_granule"
- [x]    "rc_update_ttbr0_el12"
- [x]    "virt_to_phys"
- [x]    "map_unmap_ns_s1"
- [ ]    "ns_buffer_write_byte" (* TODO: move to bottom *)
- [ ]    "data_create_s1_el1"
- [x]    "s1tte_is_writable"
- [x]    "g_mapped_addr" (* unused *)
- [x]    "granule_memzero_mapped"
- [x]    "rtt_create_s1_el1"
- [x]    "update_ripas"

### Layer 9
- [x]    "rmm_feature_register_0_value"
- [x]    "validate_map_addr"
- [x]    "feat_vmid16"
- [ ]    "mbedtls_platform_set_calloc_free"
- [ ]    "handle_instruction_abort"
- [ ]    "handle_sysreg_access_trap"
- [ ]    "handle_data_abort"
- [ ]    "handle_realm_rsi"
- [ ]    "restore_fpu_state"
- [ ]    "save_fpu_state"
- [x]    "gic_restore_state"
- [x]    "read_lr"
- [x]    "read_ap1r"
- [x]    "read_ap0r"
- [x]    "timer_is_masked"
- [x]    "timer_condition_met"
- [x]    "rsi_data_set_attrs"
- [x]    "smc_granule_undelegate"
- [x]    "smc_granule_delegate"
- [x]    "rsi_data_make_root_rtt"
- [x]    "rsi_set_ttbr0"
- [x]    "rsi_expected_result"
- [x]    "rsi_data_write"
- [x]    "rsi_rtt_map_non_secure"
- [x]    "rsi_data_read"
- [x]    "rsi_data_create_unknown_s1"
- [x]    "rsi_data_create_s1"
- [x]    "rsi_data_map_extra"
- [x]    "rsi_rtt_destroy"
- [ ]    "rcsm_rsi_log_error"
- [x]    "rsi_data_destroy"
- [x]    "rsi_rtt_create"
- [x]    "rsi_rtt_unmap_non_secure"
- [x]    "rsi_rtt_set_ripas"

### Layer 10
- [x]    "s2_inconsistent_sl"
- [x]    "validate_rmm_feature_register_0_value"
- [x]    "bitmap_test_and_set"
- [x]    "stage2_tlbi_ipa"
- [x]    "get_rd_state_locked"
- [x]    "validate_data_create_unknown"
- [x]    "realm_vtcr"
- [ ]    "psa_crypto_init"
- [ ]    "mbedtls_memory_buffer_alloc_init"
- [ ]    "handle_excpetion_irq_lel"
- [ ]    "handle_exception_sync"
- [x]    "restore_sysreg_state"
- [x]    "save_sysreg_state"
- [x]    "gic_save_state"
- [x]    "timer_output_is_asserted"
- [ ]    "rcsm_handle_realm_rsi"
- [x]    "slot_to_s1tte" (not required)
- [ ]    "va_to_s1tte" (* no use *)
- [x]    "granule_refcount_read_acquire"
- [x]    "psci_reset_rec"

### Layer 11
- [ ]    "mbedtls_sha256_init"
- [ ]    "free_sl_rtts"
- [x]    "validate_ipa_bits_and_sl"
- [x]    "validate_rmm_feature_register_value"
- [x]    "s2_num_root_rtts"
- [x]    "requested_ipa_bits"
- [x]    "vmid_reserve"
- [x]    "invalidate_page"
- [x]    "addr_block_intersects_par"
- [x]    "validate_rtt_map_cmds"
- [x]    "s2tte_is_destroyed"
- [ ]    "invalidate_block" (* Give explicit spec *)
- [x]    "s2tte_create_valid_ns"
- [x]    "s2tte_is_valid_ns"
- [ ]    "report_unexpected" (* no use *)
- [x]    "s2tte_create_valid"
- [x]    "validate_data_create"
- [x]    "status_ptr"
- [x]    "init_rec_sysregs"
- [x]    "init_common_sysregs"
- [ ]    "map_l3_ns" (* TODO: move to bottom *)
- [ ]    "crypto_init"
- [ ]    "vmid_init"
- [ ]    "gic_init"
- [ ]    "__table_maps_block"
- [ ]    "__table_is_uniform_block"
- [x]    "esr_sixty_four"
- [x]    "esr_sign_extend"
- [x]    "reset_last_run_info"
- [ ]    "handle_realm_exit"
- [ ]    "run_realm" (* moved to bottom *)
- [ ]    "configure_realm_stage2"
- [x]    "restore_realm_state" (* huge spec *)
- [x]    "save_ns_state"
- [x]    "restore_ns_state"
- [x]    "save_realm_state"
- [x]    "report_timer_state_to_ns"
- [x]    "check_pending_timers"
- [x]    "is_valid_vintid"
- [ ]    "memcpy_ns_write" (* move to bottom *)
- [ ]    "rcsm_restore_pico_state"
- [ ]    "handle_pico_rec_exit"
- [ ]    "rcsm_save_pico_state"
- [x]    "atomic_load_add_release_64" move to Bottom
- [x]    "bitmap_clear"
- [ ]    "verify_header" (* mbedtls *)
- [ ]    "llvm.umul.with.overflow.i64"
- [ ]    "complete_psci_affinity_info"
- [ ]    "complete_psci_cpu_on"

### Layer 12
- [x]    "set_rd_rec_count"
- [x]    "get_realm_params"
- [ ]    "measurement_start"
- [ ]    "find_lock_transition_rtts" (* have bug in generate low-spec? *)
- [x]    "validate_realm_params"
- [i]    "validate_ns_struct" (* seems stucked *)
- [x]    "host_ns_s2tte"
- [x]    "validate_rtt_entry_cmds"
- [x]    "map_unmap_ns"
- [ ]    "fatal_abort"
- [ ]    "is_el2_data_abort_for_os"
- [ ]    "is_el2_data_abort_gpf"
- [x]    "data_create"
- [x]    "ptr_status"
- [x]    "ptr_is_err"
- [x]    "find_lock_unused_granule"
- [x]    "get_cntfrq"
- [ ]    "ticks_to_ns_time"
- [x]    "get_rd_rec_count_locked"
- [ ]    "init_rec_regs" (*huge*)
- [ ]    "vmpidr_is_valid"
- [ ]    "gic_cpu_state_init"
- [ ]    "map_mem1"
- [ ]    "map_mem0"
- [ ]    "rmm_system_init"
- [x]    "s2tt_init_assigned"
- [x]    "validate_rtt_structure_cmds"
- [x]    "s2tt_init_destroyed"
- [x]    "s2tt_init_valid_ns"
- [x]    "__granule_refcount_inc"
- [x]    "s2tt_init_valid"
- [ ]    "table_maps_assigned_block"
- [ ]    "invalidate_pages_in_block"
- [x]    "__granule_refcount_dec"
- [ ]    "table_is_destroyed_block"
- [ ]    "table_is_unassigned_block"
- [ ]    "table_maps_valid_ns_block"
- [ ]    "table_maps_valid_block"
- [x]    "host_ns_s2tte_is_valid"
- [ ]    "read_idreg"
- [x]    "complete_mmio_emulation"
- [x]    "process_disposed_info"
- [x]    "complete_hvc_exit"
- [x]    "complete_sysreg_emulation"
- [x]    "copy_gic_state_to_ns" (* can be optimized *)
- [ ]    "rec_run_loop" (*move to bottom*)
- [ ]    "validate_gic_state" (*move to bottom*)
- [x]    "copy_gic_state_from_ns" (* can be optimized *)
- [x]    "get_rd_state_unlocked"
- [ ]    "ns_buffer_write" (*move to bottom*)
- [ ]    "pico_rec_enter"
- [x]    "atomic_granule_put_release"
- [ ]    "fake_ns_granule_map"
- [x]    "measurement_finish" (*low spec: Nothing*)
- [ ]    "fake_ns_granule_unmap"
- [ ]    "fake_ns_granule_unmap_notlbi"
- [x]    "total_root_rtt_refcount"
- [x]    "vmid_free"
- [ ]    "buffer_alloc_free_with_buf"
- [ ]    "verify_chain"
- [ ]    "buffer_alloc_calloc_with_buf"
- [ ]    "complete_psci_request"

### Layer 13
- [ ]    "llvm.va_end"
- [ ]    "mbedtls_memory_buffer_alloc_free"
- [ ]    "smc_realm_create"
- [ ]    "smc_bench_ns_map_unmap"
- [x]    "smc_rtt_unmap_protected"
- [x]    "smc_rtt_read_entry"
- [ ]    "data_granule_measure"
- [x]    "smc_rtt_unmap_non_secure" (*low-spec, unfold map_unmap_ns*)
- [ ]    "handle_rmm_trap"
- [ ]    "read8"
- [x]    "smc_data_create_unknown"
- [ ]    "uart_reg"
- [ ]    "smc_rec_destroy"
- [ ]    "s2tte_addr_type_mask"
- [ ]    "llvm.fshl.i32"
- [ ]    "smc_bench_latency"
- [ ]    "smc_rec_create"
- [ ]    "_is_digit"
- [ ]    "handle_ns_smc"
- [ ]    "rmm_init"
- [x]    "smc_rtt_map_protected"
- [x]    "smc_rtt_create"
- [ ]    "smc_system_interface_version"
- [ ]    "memmove"
- [ ]    "smc_rtt_fold" (*no use*)
- [ ]    "_putchar"
- [ ]    "memcmp"
- [ ]    "buffer_unmap"
- [x]    "smc_data_destroy"
- [ ]    "s2tte_create_destroyed"
- [x]    "smc_rtt_map_non_secure" (*low-spec, unfold map_unmap_ns*)
- [ ]    "handle_id_sysreg_trap"
- [ ]    "llvm.abs.i32"
- [x]    "smc_data_create"
- [ ]    "smc_bench_validate_ns_struct"
- [ ]    "system_rsi_abi_version"
- [x]    "smc_rtt_destroy"
- [ ]    "mbedtls_memory_buffer_set_verify"
- [x]    "smc_read_feature_register"
- [x]    "smc_data_dispose"
- [ ]    "ns_granule_map"
- [ ]    "smc_rec_enter"
- [ ]    "write8"
- [ ]    "strcmp"
- [ ]    "llvm.va_start"
- [ ]    "smc_bench_ns_fake_map"
- [x]    "stage1_tlbi_val"
- [x]    "smc_realm_activate"
- [ ]    "assert_cpu_slots_empty"
- [ ]    "smc_bench_ns_fake_unmap"
- [ ]    "measurement_update"
- [ ]    "smc_bench_ns_fake_unmap_notlbi"
- [x]    "stage1_tlbi_va"
- [ ]    "smc_realm_destroy"
- [ ]    "buffer_alloc_free"
- [ ]    "_atoi"
- [ ]    "llvm.abs.i64"
- [ ]    "handle_icc_el1_sysreg_trap"
- [ ]    "mbedtls_memory_buffer_alloc_verify"
- [ ]    "measurement_extend"
- [ ]    "buffer_alloc_calloc"
- [ ]    "smc_psci_complete"
- [ ]    "strlen"
- [ ]    "UART0_wait"
- [ ]    "_strnlen_s"

### Layer 0
- [ ]    "t_cose_sign1_encode_signature_aad"    
- [ ]    "QCBOREncode_AddInt64"
- [ ]    "t_cose_sign1_set_signing_key"
- [ ]    "QCBOREncode_AddBytesToMapN"
- [ ]    "QCBOREncode_AddBuffer"
- [ ]    "QCBOREncode_AddType7"
- [ ]    "QCBOREncode_CloseMap"
- [ ]    "QCBOREncode_AddInt64ToMapN"
- [ ]    "t_cose_sign1_sign_init"
- [ ]    "QCBOREncode_OpenMap"
- [ ]    "attest_get_rmm_attestation_key"
- [ ]    "QCBOREncode_OpenArray"
- [ ]    "attest_get_rmm_signing_key_handle"
- [ ]    "QCBOREncode_AddSimple"
- [ ]    "QCBOREncode_Init"
- [ ]    "t_cose_sign1_encode_parameters"
- [ ]    "QCBOREncode_AddBoolToMapN"
- [ ]    "attest_get_rmm_public_key_hash"
- [ ]    "t_cose_sign1_encode_signature"
- [ ]    "QCBOREncode_CloseArray"
- [ ]    "QCBOREncode_AddBool"
- [ ]    "QCBOREncode_Finish"
- [ ]    "QCBOREncode_OpenMapOrArray"
- [ ]    "QCBOREncode_CloseMapOrArray"
- [ ]    "QCBOREncode_OpenArrayInMapN"
- [ ]    "QCBOREncode_AddTextToMapN"
- [ ]    "QCBOREncode_AddText"
- [ ]    "QCBOREncode_AddBytes"
- [ ]    "printf_"
- [ ]    "attest_token_encode_finish"
- [ ]    "attest_token_encode_close_array"
- [ ]    "attest_token_encode_add_raw_bstr"
- [ ]    "attest_token_encode_open_array_in_map"
- [ ]    "attest_token_encode_add_integer"
- [ ]    "attest_get_rmm_public_key"
- [ ]    "attest_token_encode_add_bool"
- [ ]    "attest_token_encode_add_bstr"
- [ ]    "attest_token_encode_start"
- [x]    "attest_get_platform_token"
- [ ]    "attest_create_rmm_attestation_key"
- [ ]    "attest_token_encode_add_tstr"






