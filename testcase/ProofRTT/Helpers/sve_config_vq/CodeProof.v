Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.sve_config_vq.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers_sve_config_vq_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque isb_spec.
  Local Opacque read_zcr_el2_spec.
  Local Opacque write_zcr_el2_spec.
    Lemma f_sve_config_vq_correct:
      forall v_vq st st'
             (Hspec: sve_config_vq_spec_low v_vq st = Some st'),
        exec_func MakeReturnCode_layer code "sve_config_vq"
                  [VInt v_vq]
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

End Helpers_sve_config_vq_CodeProof.

