Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.find_lock_transition_rtts.LowSpec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_find_lock_transition_rtts_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_granule_spec.
  Local Opaque find_lock_granule_spec.
  Hint Unfold find_lock_transition_rtts_loop209_low:spec.
  Hint Unfold find_lock_transition_rtts_loop209_rank:spec.
  Local Opaque free_sl_rtts_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_transition_spec.
  Local Opaque make_return_code_spec.
  Local Opaque mkPtr.
  Local Opaque ptr_eqb.
  Local Opaque s2tt_init_unassigned_spec.
    Lemma f_find_lock_transition_rtts_correct:
      forall v_0 v_1 st st' res
             (Hspec: find_lock_transition_rtts_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer11_layer code "find_lock_transition_rtts"
                  [VInt v_0; VInt v_1]
                  st st' (Some (VInt res)).
Admitted.

End Layer12_find_lock_transition_rtts_CodeProof.

