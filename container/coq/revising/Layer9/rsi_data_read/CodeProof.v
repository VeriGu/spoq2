Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer8.Layer.
Require Import Layer8.Spec.
Require Import Layer9.rsi_data_read.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rsi_data_read_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque free_stack.
  Local Opaque load_RData.
  Local Opaque min_spec.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque next_granule_spec.
  Local Opaque ns_buffer_write_byte_spec.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_offset.
  Local Opaque rc_update_ttbr0_el12_spec.
  Hint Unfold rsi_data_read_loop175_low:spec.
  Hint Unfold rsi_data_read_loop175_rank:spec.
  Local Opaque store_RData.
  Local Opaque virt_to_phys_spec.
    Lemma f_rsi_data_read_correct:
      forall v_0 v_1 v_2 v_3 v_4 st st'
             (Hspec: rsi_data_read_spec_low v_0 v_1 v_2 v_3 v_4 st = Some st'),
        exec_func Layer8_layer code "rsi_data_read"
                  [VPtr v_0; VInt v_1; VInt v_2; VInt v_3; VInt v_4]
                  st st' None.
Admitted.

End Layer9_rsi_data_read_CodeProof.

