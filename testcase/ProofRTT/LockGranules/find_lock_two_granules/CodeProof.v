Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Layer.
Require Import GranuleInfo.Spec.
Require Import LockGranules.find_lock_two_granules.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section LockGranules_find_lock_two_granules_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque alloc_stack.
  Local Opacque find_lock_granules_spec.
  Local Opacque free_stack.
  Local Opacque mkPtr.
  Local Opacque new_frame.
  Local Opacque ptr_offset.
  Local Opacque ptr_to_int.
  Local Opacque store_RData.
    Lemma f_find_lock_two_granules_correct:
      forall v_addr1 v_expected_state1 v_g1 v_addr2 v_expected_state2 v_g2 st st' res
             (Hspec: find_lock_two_granules_spec_low v_addr1 v_expected_state1 v_g1 v_addr2 v_expected_state2 v_g2 st = Some (res, st')),
        exec_func GranuleInfo_layer code "find_lock_two_granules"
                  [VInt v_addr1; VInt v_expected_state1; VPtr v_g1; VInt v_addr2; VInt v_expected_state2; VPtr v_g2]
                  st st' (Some (VBool res)).
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

End LockGranules_find_lock_two_granules_CodeProof.

