Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SCA.Layer.
Require Import XLat_Helper.xlat_desc.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section XLat_Helper_xlat_desc_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_xlat_desc_correct:
      forall v_attr v_addr_pa v_level st st' res
             (Hspec: xlat_desc_spec_low v_attr v_addr_pa v_level st = Some (res, st')),
        exec_func SCA_layer code "xlat_desc"
                  [VInt v_attr; VInt v_addr_pa; VInt v_level]
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

End XLat_Helper_xlat_desc_CodeProof.

