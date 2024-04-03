Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEOps.rec_par_size.LowSpec.
Require Import S2TTEPA.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEOps_rec_par_size_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_rec_par_size_correct:
      forall v_rec st st' res
             (Hspec: rec_par_size_spec_low v_rec st = Some (res, st')),
        exec_func S2TTEPA_layer code "rec_par_size"
                  [VPtr v_rec]
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

End S2TTEOps_rec_par_size_CodeProof.

