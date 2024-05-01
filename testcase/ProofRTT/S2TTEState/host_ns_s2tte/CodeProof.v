Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Layer.
Require Import S2TTEDesc.Spec.
Require Import S2TTEState.host_ns_s2tte.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEState_host_ns_s2tte_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque addr_level_mask_spec.
    Lemma f_host_ns_s2tte_correct:
      forall v_s2tte v_level st st' res
             (Hspec: host_ns_s2tte_spec_low v_s2tte v_level st = Some (res, st')),
        exec_func S2TTEDesc_layer code "host_ns_s2tte"
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

End S2TTEState_host_ns_s2tte_CodeProof.

