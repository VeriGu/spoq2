Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEOps.s2tte_create_unassigned.LowSpec.
Require Import S2TTEPA.Layer.
Require Import S2TTEPA.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEOps_s2tte_create_unassigned_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque s2tte_create_ripas_spec.
    Lemma f_s2tte_create_unassigned_correct:
      forall v_ripas st st' res
             (Hspec: s2tte_create_unassigned_spec_low v_ripas st = Some (res, st')),
        exec_func S2TTEPA_layer code "s2tte_create_unassigned"
                  [VInt v_ripas]
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

End S2TTEOps_s2tte_create_unassigned_CodeProof.

