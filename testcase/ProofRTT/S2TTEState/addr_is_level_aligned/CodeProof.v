Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Layer.
Require Import S2TTEState.addr_is_level_aligned.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEState_addr_is_level_aligned_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_addr_is_level_aligned_correct:
      forall v_addr v_level st st' res
             (Hspec: addr_is_level_aligned_spec_low v_addr v_level st = Some (res, st')),
        exec_func S2TTEDesc_layer code "addr_is_level_aligned"
                  [VInt v_addr; VInt v_level]
                  st st' (Some (VBool res)).
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

End S2TTEState_addr_is_level_aligned_CodeProof.

