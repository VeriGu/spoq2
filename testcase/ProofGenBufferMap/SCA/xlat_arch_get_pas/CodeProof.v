Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helper.Layer.
Require Import SCA.xlat_arch_get_pas.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SCA_xlat_arch_get_pas_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_xlat_arch_get_pas_correct:
      forall v_attr st st' res
             (Hspec: xlat_arch_get_pas_spec_low v_attr st = Some (res, st')),
        exec_func Helper_layer code "xlat_arch_get_pas"
                  [VInt v_attr]
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

End SCA_xlat_arch_get_pas_CodeProof.

