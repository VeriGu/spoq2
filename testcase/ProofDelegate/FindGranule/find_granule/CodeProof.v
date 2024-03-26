Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.find_granule.LowSpec.
Require Import GlobalDefs.
Require Import GranuleState.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section FindGranule_find_granule_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_find_granule_correct:
      forall v_addr st st' res
             (Hspec: find_granule_spec_low v_addr st = Some (res, st')),
        exec_func GranuleState_layer code "find_granule"
                  [VInt v_addr]
                  st st' (Some (VPtr res)).
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

End FindGranule_find_granule_CodeProof.

