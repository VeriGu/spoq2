Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Layer.
Require Import Layer7.Spec.
Require Import Layer8.map_unmap_ns_s1.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_map_unmap_ns_s1_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __granule_get_spec.
  Local Opaque __granule_put_spec.
  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque find_granule_spec.
  Local Opaque free_stack.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_8_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s1tte_is_valid_spec.
  Local Opaque s2tte_create_unassigned_spec.
  Local Opaque s2tte_is_unassigned_spec.
  Local Opaque smc_granule_any_to_ns_spec.
  Local Opaque smc_granule_ns_to_any_spec.
  Local Opaque stage1_tlbi_all_spec.
    Lemma f_map_unmap_ns_s1_correct:
      forall v_0 v_1 v_2 v_3 v_4 st st' res
             (Hspec: map_unmap_ns_s1_spec_low v_0 v_1 v_2 v_3 v_4 st = Some (res, st')),
        exec_func Layer7_layer code "map_unmap_ns_s1"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3; VInt v_4]
                  st st' (Some (VInt res)).
Admitted.

End Layer8_map_unmap_ns_s1_CodeProof.

