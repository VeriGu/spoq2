Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Layer.
Require Import Layer8.Spec.
Require Import Layer9.rsi_data_set_attrs.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rsi_data_set_attrs_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque find_lock_granule_spec.
  Local Opaque free_stack.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_8_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque masked_assign_spec.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque stage1_tlbi_all_spec.
  Local Opaque store_RData.
    Lemma f_rsi_data_set_attrs_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: rsi_data_set_attrs_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer8_layer code "rsi_data_set_attrs"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3]
                  st st' (Some (VInt res)).
Admitted.

End Layer9_rsi_data_set_attrs_CodeProof.

