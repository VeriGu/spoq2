Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import EL3IFC.Layer.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import Mmap.Spec.
Require Import RDState.Spec.
Require Import SMCHandler.smc_realm_activate.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SMCHandler_smc_realm_activate_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque buffer_unmap_spec.
  Local Opaque find_lock_granule_spec.
  Local Opaque get_rd_state_locked_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque mkPtr.
  Local Opaque ptr_eqb.
  Local Opaque set_rd_state_spec.
    Lemma f_smc_realm_activate_correct:
      forall v_rd_addr st st' res
             (Hspec: smc_realm_activate_spec_low v_rd_addr st = Some (res, st')),
        exec_func EL3IFC_layer code "smc_realm_activate"
                  [VInt v_rd_addr]
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

End SMCHandler_smc_realm_activate_CodeProof.

