Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Layer.
Require Import Layer12.Spec.
Require Import Layer13.smc_realm_destroy.LowSpec.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_smc_realm_destroy_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_lock_unused_granule_spec.
  Local Opaque free_sl_rtts_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_memzero_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque granule_unlock_transition_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_is_err_spec.
  Local Opaque ptr_offset.
  Local Opaque ptr_status_spec.
  Local Opaque total_root_rtt_refcount_spec.
  Local Opaque vmid_free_spec.
    Lemma f_smc_realm_destroy_correct:
      forall v_0 st st' res
             (Hspec: smc_realm_destroy_spec_low v_0 st = Some (res, st')),
        exec_func Layer12_layer code "smc_realm_destroy"
                  [VInt v_0]
                  st st' (Some (VInt res)).
    Proof.
        intros; simpl_func Hspec; simpl in *;
          unshelve (eapply exec_func_call);
         (lia ||
          match goal with
          | [ |- temp_env ] => shelve
          | [ |- function ] => shelve
          | [ |- function_body ] => shelve
          | [ |- State _ ] => shelve
          | _ => idtac
          end);
         unshelve (try reflexivity; try solve [repeat vcgen | (frewrite; repeat vcgen)]);
         (lia ||
          match goal with
          | [ |- temp_env ] => shelve
          | _ => idtac
          end).
    Qed.

End Layer13_smc_realm_destroy_CodeProof.

