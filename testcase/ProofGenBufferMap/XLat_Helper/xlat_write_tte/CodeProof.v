Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SCA.Layer.
Require Import XLat_Helper.xlat_write_tte.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section XLat_Helper_xlat_write_tte_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_xlat_write_tte_correct:
      forall v_entry1 v_desc st st'
             (Hspec: xlat_write_tte_spec_low v_entry1 v_desc st = Some st'),
        exec_func SCA_layer code "xlat_write_tte"
                  [VPtr v_entry1; VInt v_desc]
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

End XLat_Helper_xlat_write_tte_CodeProof.

