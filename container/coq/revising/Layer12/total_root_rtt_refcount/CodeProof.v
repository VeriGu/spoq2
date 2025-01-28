Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer12.total_root_rtt_refcount.LowSpec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_total_root_rtt_refcount_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque g_refcount_spec.
  Local Opaque granule_lock_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque ptr_offset.
  Hint Unfold total_root_rtt_refcount_loop295_low:spec.
  Hint Unfold total_root_rtt_refcount_loop295_rank:spec.
    Lemma f_total_root_rtt_refcount_correct:
      forall v_0 v_1 st st' res
             (Hspec: total_root_rtt_refcount_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer11_layer code "total_root_rtt_refcount"
                  [VPtr v_0; VInt v_1]
                  st st' (Some (VInt res)).
Admitted.

End Layer12_total_root_rtt_refcount_CodeProof.

