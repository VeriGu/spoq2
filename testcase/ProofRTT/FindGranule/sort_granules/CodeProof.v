Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.sort_granules.LowSpec.
Require Import GlobalDefs.
Require Import GranuleState.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section FindGranule_sort_granules_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_sort_granules_correct:
      forall v_granules v_n st st'
             (Hspec: sort_granules_spec_low v_granules v_n st = Some st'),
        exec_func GranuleState_layer code "sort_granules"
                  [VPtr v_granules; VInt v_n]
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

End FindGranule_sort_granules_CodeProof.

