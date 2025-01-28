Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Layer.
Require Import Layer8.Spec.
Require Import Layer9.Spec.
Require Import Layer9.gic_restore_state.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_gic_restore_state_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Hint Unfold gic_restore_state_loop214_low:spec.
  Hint Unfold gic_restore_state_loop214_rank:spec.
  Hint Unfold gic_restore_state_loop219_low:spec.
  Hint Unfold gic_restore_state_loop219_rank:spec.
  Local Opaque iasm_35_spec.
  Local Opaque iasm_36_spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque write_ap0r_spec.
  Local Opaque write_ap1r_spec.
  Local Opaque write_lr_spec.
    Lemma f_gic_restore_state_correct:
      forall v_0 st st'
             (Hspec: gic_restore_state_spec_low v_0 st = Some st'),
        exec_func Layer8_layer code "gic_restore_state"
                  [VPtr v_0]
                  st st' None.
Admitted.

End Layer9_gic_restore_state_CodeProof.

