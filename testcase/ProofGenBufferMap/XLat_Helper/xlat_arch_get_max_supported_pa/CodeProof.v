Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SCA.Layer.
Require Import XLat_Helper.xlat_arch_get_max_supported_pa.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section XLat_Helper_xlat_arch_get_max_supported_pa_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_xlat_arch_get_max_supported_pa_correct:
      forall st st' res
             (Hspec: xlat_arch_get_max_supported_pa_spec_low st = Some (res, st')),
        exec_func SCA_layer code "xlat_arch_get_max_supported_pa"
                  []
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

End XLat_Helper_xlat_arch_get_max_supported_pa_CodeProof.

