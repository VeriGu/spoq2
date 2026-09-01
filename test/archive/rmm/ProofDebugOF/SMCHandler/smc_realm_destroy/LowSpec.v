Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import LockGranules.Spec.
Require Import MemRW.Spec.
Require Import Mmap.Spec.
Require Import RealmCreate.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_realm_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_realm_destroy_spec_low (v_rd_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((find_lock_unused_granule_spec v_rd_addr 2 st));
    let v_0 := v_call in
    when v_call1, st == ((ptr_is_err_spec v_0 st));
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_call1
        then (
          when v_call2, st == ((ptr_status_spec v_0 st));
          let v_conv := v_call2 in
          let v_retval_0 := v_conv in
          (Some (v_retval_0, st)))
        else (
          when v_call3, st == ((granule_map_spec v_call 2 st));
          let v_g_rtt4 := (ptr_offset v_call3 ((1 * (32)) + (0))) in
          let v_1 := v_g_rtt4 in
          when v_2_tmp, st == ((load_RData 8 v_1 st));
          let v_2 := (int_to_ptr v_2_tmp) in
          let v_num_root_rtts := (ptr_offset v_call3 ((1 * (24)) + (0))) in
          let v_3 := v_num_root_rtts in
          when v_4, st == ((load_RData 4 v_3 st));
          let v_vmid := (ptr_offset v_call3 ((1 * (40)) + (0))) in
          let v_5 := v_vmid in
          when v_6, st == ((load_RData 4 v_5 st));
          when st == ((vmid_free_spec v_6 st));
          when st == ((buffer_unmap_spec v_call3 st));
          when v_call7, st == ((total_root_rtt_refcount_spec v_2 v_4 st));
          let v_cmp_not := (v_call7 =? (0)) in
          when v_retval_0, st == (
              let v_retval_0 := 0 in
              if v_cmp_not
              then (
                when st == ((free_sl_rtts_spec v_2 v_4 st));
                when st == ((granule_memzero_spec v_call 2 st));
                when st == ((granule_unlock_transition_spec v_call 1 st));
                let v_retval_0 := 0 in
                (Some (v_retval_0, st)))
              else (
                when st == ((granule_unlock_spec v_call st));
                let v_retval_0 := 5 in
                (Some (v_retval_0, st))));
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End SMCHandler_smc_realm_destroy_LowSpec.

#[global] Hint Unfold smc_realm_destroy_spec_low: spec.
