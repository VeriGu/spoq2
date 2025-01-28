Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Layer.
Require Import Layer12.Spec.
Require Import Layer13.smc_rec_enter.LowSpec.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_smc_rec_enter_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque atomic_granule_get_spec.
  Local Opaque atomic_granule_put_release_spec.
  Local Opaque complete_hvc_exit_spec.
  Local Opaque complete_mmio_emulation_spec.
  Local Opaque complete_sysreg_emulation_spec.
  Local Opaque copy_gic_state_from_ns_spec.
  Local Opaque copy_gic_state_to_ns_spec.
  Local Opaque find_lock_unused_granule_spec.
  Local Opaque free_stack.
  Local Opaque get_rd_state_unlocked_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_pa_to_va_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque ns_buffer_read_spec.
  Local Opaque ns_buffer_unmap_spec.
  Local Opaque ns_buffer_write_spec.
  Local Opaque pack_return_code_spec.
  Local Opaque pico_rec_enter_spec.
  Local Opaque process_disposed_info_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque ranges_intersect_spec.
  Local Opaque rec_run_loop_spec.
  Local Opaque reset_last_run_info_spec.
  Local Opaque store_RData.
  Local Opaque validate_gic_state_spec.
  Local Opaque validate_ns_struct_spec.
    Lemma f_smc_rec_enter_correct:
      forall v_0 v_1 v_2 v_3 st st'
             (Hspec: smc_rec_enter_spec_low v_0 v_1 v_2 v_3 st = Some st'),
        exec_func Layer12_layer code "smc_rec_enter"
                  [VInt v_0; VInt v_1; VInt v_2; VPtr v_3]
                  st st' None.
Admitted.

End Layer13_smc_rec_enter_CodeProof.

