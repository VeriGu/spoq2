Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleState.Spec.
Require Import InitRec.Spec.
Require Import LockGranules.Spec.
Require Import MemRW.Spec.
Require Import Mmap.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section SMCHandler_smc_rec_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rec_destroy_spec_low (v_rec_addr: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st_0 == ((find_lock_unused_granule_spec v_rec_addr 3 st));
    when v_call1, st_1 == ((ptr_is_err_spec v_call st_0));
    if v_call1
    then (
      when v_call2, st_2 == ((ptr_status_spec v_call st_1));
      (Some (v_call2, st_2)))
    else (
      when v_call3, st_2 == ((granule_map_spec v_call 3 st_1));
      when v_2_tmp, st_3 == ((load_RData 8 (ptr_offset v_call3 904) st_2));
      when v_4, st_4 == ((load_RData 4 (ptr_offset v_call3 964) st_3));
      when st_5 == ((free_rec_aux_granules_spec (ptr_offset v_call3 968) v_4 true st_4));
      when st_6 == ((granule_memzero_mapped_spec v_call3 st_5));
      when st_7 == ((buffer_unmap_spec v_call3 st_6));
      when st_8 == ((granule_unlock_transition_spec v_call 1 st_7));
      when st_9 == ((atomic_granule_put_spec (int_to_ptr v_2_tmp) st_8));
      (Some (0, st_9))).

End SMCHandler_smc_rec_destroy_LowSpec.

#[global] Hint Unfold smc_rec_destroy_spec_low: spec.
