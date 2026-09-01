Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.granule_lock_on_state_match.LowSpec.
Require Import GlobalDefs.
Require Import GranuleState.Layer.
Require Import GranuleState.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section FindGranule_granule_lock_on_state_match_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque ST_GRANULE_SIZE.
  Local Opaque granule_get_state_spec.
  Local Opaque ptr_offset.
  Local Opaque spinlock_acquire_spec.
  Local Opaque spinlock_release_spec.
    Lemma f_granule_lock_on_state_match_correct:
      forall v_g v_expected_state st st' res
             (Hspec: granule_lock_on_state_match_spec_low v_g v_expected_state st = Some (res, st')),
        exec_func GranuleState_layer code "granule_lock_on_state_match"
                  [VPtr v_g; VInt v_expected_state]
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

End FindGranule_granule_lock_on_state_match_CodeProof.

