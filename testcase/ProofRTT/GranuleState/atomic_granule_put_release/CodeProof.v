Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.atomic_granule_put_release.LowSpec.
Require Import RDState.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section GranuleState_atomic_granule_put_release_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque ST_GRANULE_SIZE.
  Local Opacque atomic_load_add_release_64_spec.
  Local Opacque ptr_offset.
    Lemma f_atomic_granule_put_release_correct:
      forall v_g st st'
             (Hspec: atomic_granule_put_release_spec_low v_g st = Some st'),
        exec_func RDState_layer code "atomic_granule_put_release"
                  [VPtr v_g]
                  st st' None.
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

End GranuleState_atomic_granule_put_release_CodeProof.

