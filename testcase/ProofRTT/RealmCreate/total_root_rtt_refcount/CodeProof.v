Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import MemRW.Layer.
Require Import RealmCreate.Spec.
Require Import RealmCreate.total_root_rtt_refcount.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RealmCreate_total_root_rtt_refcount_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque granule_lock_spec.
  Local Opacque granule_unlock_spec.
  Local Opacque load_RData.
  Local Opacque ptr_offset.
  Hint Unfold total_root_rtt_refcount_loop348_low:spec.
  Hint Unfold total_root_rtt_refcount_loop348_rank:spec.
    Lemma f_total_root_rtt_refcount_correct:
      forall v_g_rtt v_num_rtts st st' res
             (Hspec: total_root_rtt_refcount_spec_low v_g_rtt v_num_rtts st = Some (res, st')),
        exec_func MemRW_layer code "total_root_rtt_refcount"
                  [VPtr v_g_rtt; VInt v_num_rtts]
                  st st' (Some (VInt res)).
Admitted.

End RealmCreate_total_root_rtt_refcount_CodeProof.

