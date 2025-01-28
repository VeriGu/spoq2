Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Layer.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer6.s2tt_init_unassigned.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_s2tt_init_unassigned_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_10_spec.
  Local Opaque ptr_offset.
  Local Opaque s2tt_init_unassigned_loop759_0_low.
  Local Opaque s2tt_init_unassigned_loop759_0_rank.
  Hint Unfold s2tt_init_unassigned_loop759_low:spec.
  Hint Unfold s2tt_init_unassigned_loop759_rank:spec.
  Local Opaque s2tte_create_unassigned_spec.
  Local Opaque store_RData.
    Lemma f_s2tt_init_unassigned_correct:
      forall v_0 v_1 st st'
             (Hspec: s2tt_init_unassigned_spec_low v_0 v_1 st = Some st'),
        exec_func Layer5_layer code "s2tt_init_unassigned"
                  [VPtr v_0; VInt v_1]
                  st st' None.
Admitted.

End Layer6_s2tt_init_unassigned_CodeProof.

