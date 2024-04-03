Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEPA.s2tte_pa.LowSpec.
Require Import S2TTEState.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEPA_s2tte_pa_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2tte_pa_correct:
      forall v_s2tte v_level st st' res
             (Hspec: s2tte_pa_spec_low v_s2tte v_level st = Some (res, st')),
        exec_func S2TTEState_layer code "s2tte_pa"
                  [VInt v_s2tte; VInt v_level]
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

End S2TTEPA_s2tte_pa_CodeProof.

