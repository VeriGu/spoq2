Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.gic_save_state.LowSpec.
Require Import Layer9.Layer.
Require Import Layer9.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_gic_save_state_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque gic_restore_state_spec.
  Hint Unfold gic_save_state_loop230_low:spec.
  Hint Unfold gic_save_state_loop230_rank:spec.
  Hint Unfold gic_save_state_loop235_low:spec.
  Hint Unfold gic_save_state_loop235_rank:spec.
  Local Opaque iasm_37_spec.
  Local Opaque iasm_38_spec.
  Local Opaque iasm_39_spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque read_ap0r_spec.
  Local Opaque read_ap1r_spec.
  Local Opaque read_lr_spec.
  Local Opaque store_RData.
    Lemma f_gic_save_state_correct:
      forall v_0 st st'
             (Hspec: gic_save_state_spec_low v_0 st = Some st'),
        exec_func Layer9_layer code "gic_save_state"
                  [VPtr v_0]
                  st st' None.
Admitted.

End Layer10_gic_save_state_CodeProof.

